import 'dart:async';
import 'dart:convert';

import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/home_dropdown.dart';
import 'package:citytaxi/components/progress_dialog.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/direction_details.dart';
import 'package:citytaxi/models/online_nearby_drivers.dart';
import 'package:citytaxi/screens/aboutus_screen.dart';
import 'package:citytaxi/screens/passenger_screen/drawer/users_trips_history_page.dart';
import 'package:citytaxi/screens/passenger_screen/nearby_drivers.dart';
import 'package:citytaxi/screens/passenger_screen/rate_driver_screen.dart';
import 'package:citytaxi/screens/passenger_screen/search_destination.dart';
import 'package:citytaxi/screens/passenger_screen/widgets/info_dialog.dart';
import 'package:citytaxi/screens/passenger_screen/widgets/payment_dialog.dart';
import 'package:citytaxi/screens/profile_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/utils/appInfo/app_info.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:citytaxi/utils/global/trip_variable.dart';
import 'package:citytaxi/utils/methods/common_methods.dart';
import 'package:citytaxi/utils/methods/manage_drivers_methods.dart';
import 'package:citytaxi/utils/methods/push_notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';

class PHomeScreen extends StatefulWidget {
  const PHomeScreen({super.key});

  @override
  State<PHomeScreen> createState() => _PHomeScreenState();
}

class _PHomeScreenState extends State<PHomeScreen> {
  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  Position? currenctPositionOfUser;
  double searchContainerHeight = 276;
  double bottomMapPadding = 0;
  double rideDetailsContainerHeight = 0;
  double requestContainerHeight = 0;
  double tripContainerHeight = 0;
  DirectionDetails? tripDirectionDetailsInfo;
  List<LatLng> polylineCoOrdinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};
  bool isDefaultScreen = true;
  String stateOfApp = "normal";
  bool nearbyOnlineDriversKeysLoaded = false;
  BitmapDescriptor? carIconNearbyDriver;
  DatabaseReference? tripRequestRef;
  List<OnlineNearbyDrivers>? availableNearbyOnlineDriversList;
  StreamSubscription<DatabaseEvent>? tripstreamSubscription;
  bool requestingDirectionDetailsInfo = false;

  makeDriverNearbyCarIcon() {
    if (carIconNearbyDriver == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context, size: const Size(1, 1));
      BitmapDescriptor.fromAssetImage(configuration, "assets/logo/icons/tracking1.png").then((iconImage) {
        carIconNearbyDriver = iconImage;
      });
    }
  }

// theme path in json
  void updateMapTheme(GoogleMapController controller) {
    getJsonFileFromThemes("themes/retro_style.json").then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String mapStylePath) async {
    ByteData byteData = await rootBundle.load(mapStylePath);
    var list = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  setGoogleMapStyle(String googleMapStyle, GoogleMapController controller) {
    controller.setMapStyle(googleMapStyle);
  }

  //get the users current location
  getCurrentLiveLocationOfUser() async {
    Position positionOfUser = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currenctPositionOfUser = positionOfUser;

    LatLng positionOfUserInLatLng = LatLng(currenctPositionOfUser!.latitude, currenctPositionOfUser!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: positionOfUserInLatLng, zoom: 18);
    //display the current location of the user
    controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    await CommonMethods.convertGeoGraphicCoorIntoHumanReadableAddress(currenctPositionOfUser!, context);

    await initializeGeoFireListner(); // Geo fire initialization
  }

  displayUserRideDetailsContainer() async {
    // directions API- draw route between pickup and dropoff
    await retrieveDirectionDetails();

    setState(() {
      searchContainerHeight = 0;
      bottomMapPadding = 240;
      rideDetailsContainerHeight = 242;
      isDefaultScreen = false;
    });
  }

  retrieveDirectionDetails() async {
    var pickUpLocation = Provider.of<AppInfo>(context, listen: false).pickUpLocation;
    var dropOffDestinationLocation = Provider.of<AppInfo>(context, listen: false).dropOffLocation;

    var pickupGeoGraphicCoOrdinates = LatLng(pickUpLocation!.latitudePosition!, pickUpLocation.longitudePosition!);
    var dropOffDestinationGeoGraphicCoOrdinates = LatLng(dropOffDestinationLocation!.latitudePosition!, dropOffDestinationLocation.longitudePosition!);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ProgressDialog(message: "Getting direction..."),
    );

    // Directions API
    var detailsFromDirectionAPI = await CommonMethods.getDrectionDetailsFromAPI(pickupGeoGraphicCoOrdinates, dropOffDestinationGeoGraphicCoOrdinates);
    setState(() {
      tripDirectionDetailsInfo = detailsFromDirectionAPI;
    });

    Navigator.pop(context);

    // draw route from pickup to drop off location
    PolylinePoints pointsPolyline = PolylinePoints();
    List<PointLatLng> latLngPointsFromPickUpToDestination = pointsPolyline.decodePolyline(tripDirectionDetailsInfo!.encodedPoints!);

    polylineCoOrdinates.clear();

    if (latLngPointsFromPickUpToDestination.isNotEmpty) {
      latLngPointsFromPickUpToDestination.forEach((PointLatLng latLngPoint) {
        polylineCoOrdinates.add(
          LatLng(latLngPoint.latitude, latLngPoint.longitude),
        );
      });
    }

    polylineSet.clear();
    // draw polyline from pickup to drop off location
    setState(() {
      Polyline polyline = Polyline(
        polylineId: const PolylineId("polylineID"),
        color: Colors.pink,
        points: polylineCoOrdinates,
        jointType: JointType.round,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      // ponint to point
      polylineSet.add(polyline);
    });

    // fit the polyline into the map
    LatLngBounds boundsLatLng;

    if (pickupGeoGraphicCoOrdinates.latitude > dropOffDestinationGeoGraphicCoOrdinates.latitude && pickupGeoGraphicCoOrdinates.longitude > dropOffDestinationGeoGraphicCoOrdinates.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: dropOffDestinationGeoGraphicCoOrdinates,
        northeast: pickupGeoGraphicCoOrdinates,
      );
    } else if (pickupGeoGraphicCoOrdinates.longitude > dropOffDestinationGeoGraphicCoOrdinates.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(pickupGeoGraphicCoOrdinates.latitude, dropOffDestinationGeoGraphicCoOrdinates.longitude),
        northeast: LatLng(dropOffDestinationGeoGraphicCoOrdinates.latitude, pickupGeoGraphicCoOrdinates.longitude),
      );
    } else if (pickupGeoGraphicCoOrdinates.latitude > dropOffDestinationGeoGraphicCoOrdinates.latitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(dropOffDestinationGeoGraphicCoOrdinates.latitude, pickupGeoGraphicCoOrdinates.longitude),
        northeast: LatLng(pickupGeoGraphicCoOrdinates.latitude, dropOffDestinationGeoGraphicCoOrdinates.longitude),
      );
    } else {
      boundsLatLng = LatLngBounds(
        southwest: pickupGeoGraphicCoOrdinates,
        northeast: dropOffDestinationGeoGraphicCoOrdinates,
      );
    }

    //
    controllerGoogleMap!.animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 72));

    // add markers to pickup nd drop off point
    Marker pickUpPointMarker = Marker(
      markerId: const MarkerId("pickUpPointMarkerID"),
      position: pickupGeoGraphicCoOrdinates,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: pickUpLocation.placeName, snippet: "Pickup Location"),
    );

    Marker dropOffDestinationPointMarker = Marker(
      markerId: const MarkerId("dropOffDestinationPointMarkerID"),
      position: dropOffDestinationGeoGraphicCoOrdinates,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: dropOffDestinationLocation.placeName, snippet: "Drop Off Location"),
    );

    setState(() {
      markerSet.add(pickUpPointMarker);
      markerSet.add(dropOffDestinationPointMarker);
    });

    // add circles to pickup nd drop off point
    Circle pickUpPointCircle = Circle(
      circleId: const CircleId('pickupCircleID'),
      strokeColor: Colors.pink, // border
      strokeWidth: 4,
      radius: 14,
      center: pickupGeoGraphicCoOrdinates,
      fillColor: Colors.pink,
    );
    Circle dropOffDestinationPointCircle = Circle(
      circleId: const CircleId('dropOffDestinationCircleID'),
      strokeColor: Colors.blue, // border
      strokeWidth: 4,
      radius: 14,
      center: dropOffDestinationGeoGraphicCoOrdinates,
      fillColor: Colors.pink,
    );

    setState(() {
      circleSet.add(pickUpPointCircle);
      circleSet.add(dropOffDestinationPointCircle);
    });
  }

  bool isDropdownVisible = false;

  resetAppNow() {
    setState(() {
      polylineCoOrdinates.clear();
      polylineSet.clear();
      markerSet.clear();
      circleSet.clear();
      rideDetailsContainerHeight = 0;
      requestContainerHeight = 0;
      tripContainerHeight = 0;
      searchContainerHeight = 276;
      bottomMapPadding = 300;
      isDefaultScreen = true;

      status = "";
      nameDriver = "";
      phoneNumberDriver = "";
      carDetailsDriver = "";
      tripStatusDisplay = "Driver is Arriving";
    });
  }

  cancelRideRequest() {
    // remove ride request from db
    tripRequestRef!.remove();

    setState(() {
      stateOfApp = "normal";
    });
  }

  displayRequestContainer() {
    setState(() {
      rideDetailsContainerHeight = 0;
      requestContainerHeight = 220;
      bottomMapPadding = 200;
      isDefaultScreen = true;
    });

    // send ride request
    makeTripRequest();
  }

  updateAvailableNearbyOnlineDriversOnMap() {
    setState(() {
      markerSet.clear();
    });

    Set<Marker> markersTempSet = Set<Marker>();

// ex- 5 online drivers, get their details one by one nd showing the marekr ,icon
    for (OnlineNearbyDrivers eachOnlineNearbyDriver in ManageDriversMethods.nearbyOnlineDriversList) {
      LatLng driverCurrentPosition = LatLng(eachOnlineNearbyDriver.latDriver!, eachOnlineNearbyDriver.lngDriver!);

      Marker driverMarker = Marker(
        markerId: MarkerId("driver ID = " + eachOnlineNearbyDriver.uidDriver.toString()),
        position: driverCurrentPosition,
        icon: carIconNearbyDriver!,
      );

      markersTempSet.add(driverMarker); // that 5 markers in the markersTempSet
    }

    setState(() {
      markerSet = markersTempSet;
    });
  }

  // get all nearest, online drivers current location.
  initializeGeoFireListner() {
    Geofire.initialize("onlineDrivers");
    // within the radius 22, get all online drivers of this user
    Geofire.queryAtLocation(
      currenctPositionOfUser!.latitude,
      currenctPositionOfUser!.longitude,
      22,
    )!
        .listen((driverEvent) {
      if (driverEvent != null) {
        var onlineDriverChild = driverEvent["callBack"];

        switch (onlineDriverChild) {
          //1
          case Geofire.onKeyEntered: // new driver came inside the radius

            OnlineNearbyDrivers onlineNearbyDrivers = OnlineNearbyDrivers();
            onlineNearbyDrivers.uidDriver = driverEvent["key"]; // driver id
            onlineNearbyDrivers.latDriver = driverEvent["latitude"];
            onlineNearbyDrivers.lngDriver = driverEvent["longitude"];
            ManageDriversMethods.nearbyOnlineDriversList.add(onlineNearbyDrivers);

            if (nearbyOnlineDriversKeysLoaded == true) {
              // update drivers on google map
              updateAvailableNearbyOnlineDriversOnMap();
            }

            break;

          //2
          case Geofire.onKeyExited: // driver went outside from the users radius
            ManageDriversMethods.removeDriverFromList(driverEvent["key"]);
            // update drivers on google map
            updateAvailableNearbyOnlineDriversOnMap();

            break;

          //3
          case Geofire.onKeyMoved: // driver move within the radius

            OnlineNearbyDrivers onlineNearbyDrivers = OnlineNearbyDrivers();
            onlineNearbyDrivers.uidDriver = driverEvent["key"];
            onlineNearbyDrivers.latDriver = driverEvent["latitude"];
            onlineNearbyDrivers.lngDriver = driverEvent["longitude"];
            ManageDriversMethods.updateOnlineNearbyDriversLocation(onlineNearbyDrivers);

            // update drivers on google map
            updateAvailableNearbyOnlineDriversOnMap();

            break;

          //4
          case Geofire.onGeoQueryReady: // first, whenever user open the app, display nearest online drivers
            nearbyOnlineDriversKeysLoaded = true;
            // update drivers on google map
            updateAvailableNearbyOnlineDriversOnMap();
            break;
        }
      }
    });
  }

// user making new trip request
  makeTripRequest() {
    tripRequestRef = FirebaseDatabase.instance.ref().child("tripRequests").push();

    var pickUpLocation = Provider.of<AppInfo>(context, listen: false).pickUpLocation;
    var dropOffDestinationLocation = Provider.of<AppInfo>(context, listen: false).dropOffLocation;

    Map pickUpCoOrdinatesMap = {
      "latitude": pickUpLocation!.latitudePosition.toString(),
      "longitude": pickUpLocation.longitudePosition.toString(),
    };

    Map dropOffDestinationCoOrdinatesMap = {
      "latitude": dropOffDestinationLocation!.latitudePosition.toString(),
      "longitude": dropOffDestinationLocation.longitudePosition.toString(),
    };

    Map driverCoOrdinates = {
      "latitude": "",
      "longitude": "",
    };

// data for new trip
    Map dataMap = {
      "tripID": tripRequestRef!.key,
      "publishDateTime": DateTime.now().toString(),

      // user info
      "userName": userName,
      "userPhone": userPhone,
      "userID": userID,
      "pickUpLatLng": pickUpCoOrdinatesMap,
      "dropOffLatLng": dropOffDestinationCoOrdinatesMap,
      "pickUpAddress": pickUpLocation.placeName,
      "dropOffAddress": dropOffDestinationLocation.placeName,

      //
      "driverID": "waiting",
      "carDetails": "",
      "driverLocation": driverCoOrdinates,
      "driverName": "",
      "driverPhone": "",
      "fareAmount": "",
      "status": "new",
    };

    tripRequestRef!.set(dataMap);

    tripstreamSubscription = tripRequestRef!.onValue.listen((eventSnapshot) async {
      if (eventSnapshot.snapshot.value == null) {
        return;
      }
      if ((eventSnapshot.snapshot.value as Map)["driverName"] != null) {
        nameDriver = (eventSnapshot.snapshot.value as Map)["driverName"];
      }
      if ((eventSnapshot.snapshot.value as Map)["driverPhone"] != null) {
        phoneNumberDriver = (eventSnapshot.snapshot.value as Map)["driverPhone"];
      }
      if ((eventSnapshot.snapshot.value as Map)["carDetails"] != null) {
        carDetailsDriver = (eventSnapshot.snapshot.value as Map)["carDetails"];
      }
      if ((eventSnapshot.snapshot.value as Map)["status"] != null) {
        status = (eventSnapshot.snapshot.value as Map)["status"];
      }
      if ((eventSnapshot.snapshot.value as Map)["driverLocation"] != null) {
        double driverLatitude = double.parse((eventSnapshot.snapshot.value as Map)["driverLocation"]["latitude"].toString());
        double driverLongitude = double.parse((eventSnapshot.snapshot.value as Map)["driverLocation"]["longitude"].toString());

        LatLng driverCurrentLocationLatLng = LatLng(driverLatitude, driverLongitude);

        if (status == "accepted") {
          // update information for pickup to user UI
          // driver current location to user pickup location
          updateFromDriverCurrentLocationToPickup(driverCurrentLocationLatLng);
        } else if (status == "arrived") {
          // update into for arrived - when driver reach at the pickup point of user
          setState(() {
            tripStatusDisplay = "Driver has Arrived";
          });
        }
        // when driver clicked ontrip
        else if (status == "ontrip") {
          // update into for dropoff to user UI
          // infor from driver current location to user dropoff location
          updateFromDriverCurrentLocationToDropOffDestination(driverCurrentLocationLatLng);
        }
      }

      //
      if (status == "accepted") {
        displayTripDetailsContainer();
        Geofire.stopListener();
        // remove drivers markers
        setState(() {
          markerSet.removeWhere((element) => element.markerId.value.contains("driver"));
        });
      }
      //
      if (status == "ended") {
        if ((eventSnapshot.snapshot.value as Map)["fareAmount"] != null) {
          double fareAmount = double.parse((eventSnapshot.snapshot.value as Map)["fareAmount"].toString());

          var responseFromPaymentDialog = await showDialog(
            context: context,
            builder: (BuildContext context) => PaymentDialog(fareAmount: fareAmount.toString()),
          );

          if (responseFromPaymentDialog == "paid") {
            if ((eventSnapshot.snapshot.value as Map)["driverID"] != null) {
              String assignedDriverID = (eventSnapshot.snapshot.value as Map)["driverID"].toString();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RateDriverScreen(
                            assignedDriverId: assignedDriverID,
                          )));
            }
            tripRequestRef!.onDisconnect();
            tripRequestRef = null;

            tripstreamSubscription!.cancel();
            tripstreamSubscription = null;

            // resetAppNow();

            // Restart.restartApp();
          }
        }
      }
    });
  }

  displayTripDetailsContainer() {
    setState(() {
      requestContainerHeight = 0;
      tripContainerHeight = 291;
      bottomMapPadding = 281;
    });
  }

  updateFromDriverCurrentLocationToPickup(driverCurrentLocationLatLng) async {
    if (!requestingDirectionDetailsInfo) {
      requestingDirectionDetailsInfo = true;

      var userPickUplocationLatLng = LatLng(currenctPositionOfUser!.latitude, currenctPositionOfUser!.longitude);

      var directionDetailsPickUp = await CommonMethods.getDrectionDetailsFromAPI(driverCurrentLocationLatLng, userPickUplocationLatLng);

      if (directionDetailsPickUp == null) {
        return;
      }
      setState(() {
        tripStatusDisplay = "Driver is Coming - ${directionDetailsPickUp.durationTextString}";
      });

      requestingDirectionDetailsInfo = false;
    }
  }

  updateFromDriverCurrentLocationToDropOffDestination(driverCurrentLocationLatLng) async {
    if (!requestingDirectionDetailsInfo) {
      requestingDirectionDetailsInfo = true;

      var dropOffLocation = Provider.of<AppInfo>(context, listen: false).dropOffLocation;
      var userDropOfflocationLatLng = LatLng(dropOffLocation!.latitudePosition!, dropOffLocation.longitudePosition!);

      var directionDetailsPickUp = await CommonMethods.getDrectionDetailsFromAPI(driverCurrentLocationLatLng, userDropOfflocationLatLng);

      if (directionDetailsPickUp == null) {
        return;
      }
      setState(() {
        tripStatusDisplay = "Driving to DropOff Location - ${directionDetailsPickUp.durationTextString}";
      });

      requestingDirectionDetailsInfo = false;
    }
  }

  noDriverAvailable() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => InfoDialog(
        title: "No Driver Available",
        description: "No Driver found in the nearby location. Please try again shortly",
      ),
    );
  }

  //
  searchDriver() {
    if (availableNearbyOnlineDriversList!.length == 0) {
      cancelRideRequest();
      resetAppNow();
      noDriverAvailable();
      return;
    }

    var currentDriver = availableNearbyOnlineDriversList![0];

    // send push notfication to this current Driver. means selected driver
    sendNotificationToDriver(currentDriver);

    availableNearbyOnlineDriversList!.removeAt(0);
  }

  sendNotificationToDriver(OnlineNearbyDrivers currentDriver) {
    // update driver's newTripStatus - asign tripID to current driver
    DatabaseReference currentDriverRef = FirebaseDatabase.instance.ref().child("drivers").child(currentDriver.uidDriver.toString()).child("newTripStatus");

    currentDriverRef.set(tripRequestRef!.key);

    // get current driver registration recognition token
    DatabaseReference tokenOfCurrentDriverRef = FirebaseDatabase.instance.ref().child("drivers").child(currentDriver.uidDriver.toString()).child("deviceToken");

    tokenOfCurrentDriverRef.once().then((dataSnapshot) {
      if (dataSnapshot.snapshot.value != null) {
        String deviceToken = dataSnapshot.snapshot.value.toString();

        //send notification
        PushNotificationService.sendNotificationToSelectedDriver(
          deviceToken,
          context,
          tripRequestRef!.key.toString(),
        );
      } else {
        return;
      }
      const oneTickPerSec = Duration(seconds: 1);

      var timeCountDown = Timer.periodic(oneTickPerSec, (timer) {
        requestTimeoutDriver = requestTimeoutDriver - 1;

        // when trip request is not requesting- trip request is cancelled - stop timer
        if (stateOfApp != "requesting") {
          timer.cancel();
          currentDriverRef.set("cancelled");
          currentDriverRef.onDisconnect();
          requestTimeoutDriver = 20;
        }

        // when trip request is accepted by online nearest available driver
        currentDriverRef.onValue.listen((dataSnapshot) {
          if (dataSnapshot.snapshot.value.toString() == "accepted") {
            timer.cancel();
            currentDriverRef.onDisconnect();
            requestTimeoutDriver = 20;
          }
        });

        // if 20 seconds passed - when driver ignore - send notification to next nearest online driver
        if (requestTimeoutDriver == 0) {
          currentDriverRef.set("timeout");
          timer.cancel();
          currentDriverRef.onDisconnect();
          requestTimeoutDriver = 20;

          //send notification to next nearest online driver
          searchDriver();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    makeDriverNearbyCarIcon();
    return Scaffold(
      //   backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Palette.mainColor60,
        toolbarHeight: 56,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          // close icon for cancel the route
          onPressed: () {
            if (isDefaultScreen == true) {
              isDefaultScreen = !isDefaultScreen;
            } else {
              resetAppNow();
            }
          },
          icon: Icon(
            isDefaultScreen == true ? Icons.person_2_rounded : Icons.close_rounded,
            color: Palette.white,
          ),
        ),
        title: Text(
          'Search Vehicle   -   Start A Ride',
          style: Theme.of(context).textTheme.normal18,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDropdownVisible = !isDropdownVisible;
              });
            },
            icon: Icon(
              Icons.menu,
              color: Palette.white,
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          // google map
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            polylines: polylineSet,
            markers: markerSet,
            circles: circleSet,
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;
              googleMapCompleterController.complete(mapController);

              // black theme google map
              updateMapTheme(controllerGoogleMap!);
              // current location of the user
              getCurrentLiveLocationOfUser();
            },
          ),

          // old UI
          const SizedBox(
            // height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 56,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Column(
                //   children: [
                //     Text(
                //       'Search Vehicle',
                //       style: Theme.of(context).textTheme.bold16,
                //     ),
                //     const SizedBox(height: 4),
                //     Text(
                //       'START A RIDE',
                //       style: Theme.of(context).textTheme.bold24,
                //     )
                //   ],
                // ),
                SizedBox(height: 56),
                // Container(
                //   margin: const EdgeInsets.all(16),
                //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
                //   clipBehavior: Clip.antiAlias,
                //   decoration: BoxDecoration(
                //     color: Palette.black.withOpacity(0.3),
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   child: Column(
                //     children: [
                //       TextFormField(
                //         style: TextStyle(color: Palette.white),
                //         decoration: InputDecoration(
                //           labelText: 'PICKUP',
                //           labelStyle: TextStyle(color: Palette.white),
                //           focusedBorder: UnderlineInputBorder(
                //             borderSide: BorderSide(color: Palette.white),
                //           ),
                //           enabledBorder: UnderlineInputBorder(
                //             borderSide: BorderSide(color: Palette.white),
                //           ),
                //         ),
                //         cursorColor: Palette.white,
                //         autocorrect: false,
                //         textCapitalization: TextCapitalization.none,
                //       ),
                //       const SizedBox(height: 48),
                //       TextFormField(
                //         style: TextStyle(color: Palette.white),
                //         decoration: InputDecoration(
                //           labelText: 'DROP-OFF',
                //           labelStyle: TextStyle(color: Palette.white),
                //           focusedBorder: UnderlineInputBorder(
                //             borderSide: BorderSide(color: Palette.white),
                //           ),
                //           enabledBorder: UnderlineInputBorder(
                //             borderSide: BorderSide(color: Palette.white),
                //           ),
                //         ),
                //         cursorColor: Palette.white,
                //         autocorrect: false,
                //         textCapitalization: TextCapitalization.none,
                //       ),
                //       const SizedBox(height: 64),
                //       FillButton(
                //         onTapped: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => const PNearDrivers(),
                //             ),
                //           );
                //         },
                //         text: 'Search',
                //         color: Palette.mainColor30,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),

          // drawer
          Positioned(
            top: 0.0, // Adjust the top position as needed
            right: 16.0, // Adjust the right position as needed
            child: Visibility(
              visible: isDropdownVisible,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5.0),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeDropdown(
                      name: 'Profile',
                      icon: Icons.account_circle_rounded,
                      goTo: ProfileScreen(),
                    ),
                    Container(width: 120, height: 1, color: Palette.black),
                    const HomeDropdown(
                      name: 'History',
                      icon: Icons.lightbulb_circle,
                      goTo: UsersTripsHistoryPage(),
                    ),
                    Container(width: 120, height: 1, color: Palette.black),
                    const HomeDropdown(
                      name: 'About',
                      icon: Icons.lightbulb_circle,
                      goTo: AboutusScreen(),
                    ),
                    Container(width: 120, height: 1, color: Palette.black),
                    HomeDropdown(
                      name: 'Signout',
                      icon: Icons.exit_to_app_rounded,
                      //   goTo: WelcomeScreen(),
                      onSignOut: () async {
                        await FirebaseAuth.instance.signOut();
                        Fluttertoast.showToast(msg: 'Signed out successfully');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // search location icon button
          Positioned(
            left: 0,
            right: 0,
            bottom: -80,
            child: Container(
              height: searchContainerHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // search
                  ElevatedButton(
                    onPressed: () async {
                      var responseFromSearchPage = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchDestinationPage(),
                          ));
                      if (responseFromSearchPage == "placeSelected") {
                        // String dropOffLocation = Provider.of<AppInfo>(context, listen: false).dropOffLocation!.placeName ?? "";
                        // print("dropOffLocation = " + dropOffLocation);

                        displayUserRideDetailsContainer();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Palette.mainColor60,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Palette.white,
                      size: 25,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Palette.mainColor60,
                    ),
                    child: Icon(
                      Icons.home,
                      color: Palette.white,
                      size: 25,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Palette.mainColor60,
                    ),
                    child: Icon(
                      Icons.work,
                      color: Palette.white,
                      size: 25,
                    ),
                  )
                ],
              ),
            ),
          ),

          // ride details container
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: rideDetailsContainerHeight,
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 70,
                          decoration: BoxDecoration(color: Palette.black, borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // duration
                                    Text(
                                      "In ${(tripDirectionDetailsInfo != null) ? tripDirectionDetailsInfo!.durationTextString! : ""}   -",
                                      style: Theme.of(context).textTheme.normal16.copyWith(color: Palette.white),
                                    ),
                                    const SizedBox(width: 10),
                                    // km
                                    Text(
                                      (tripDirectionDetailsInfo != null) ? tripDirectionDetailsInfo!.distanceTextString! : "",
                                      style: Theme.of(context).textTheme.normal16.copyWith(color: Palette.white),
                                    ),
                                  ],
                                ),

                                // vehicle pic
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      stateOfApp = "requesting";
                                    });

                                    displayRequestContainer();

                                    // get nearest available online drivers
                                    availableNearbyOnlineDriversList = ManageDriversMethods.nearbyOnlineDriversList;

                                    //search driver
                                    searchDriver();
                                  },
                                  child: Image.asset(
                                    "assets/logo/images/blackCar.png",
                                    height: 122,
                                    width: 122,
                                  ),
                                ),
                                // $
                                Text(
                                  (tripDirectionDetailsInfo != null) ? "LKR ${(CommonMethods.calculateFareAmount(tripDirectionDetailsInfo!)).toString()}" : "",
                                  style: Theme.of(context).textTheme.normal18.copyWith(color: Palette.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // request container
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                height: requestContainerHeight,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 200,
                        child: LoadingAnimationWidget.flickr(
                          leftDotColor: Colors.greenAccent,
                          rightDotColor: Colors.pinkAccent,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // cancel button for cancel the ride request when loading
                      GestureDetector(
                        onTap: () {
                          resetAppNow();
                          cancelRideRequest();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1.5, color: Colors.grey),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Palette.black,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),

          // trip details container
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              height: tripContainerHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    // trip status disply
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tripStatusDisplay,
                          style: const TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 19),
                    const Divider(
                      height: 1,
                      color: Colors.white70,
                      thickness: 1,
                    ),
                    const SizedBox(height: 19),

                    // driver name , driver car details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.network(
                            // "assets/logo/images/profile.png",
                            "https://firebasestorage.googleapis.com/v0/b/city-taxi-93be1.appspot.com/o/profile.png?alt=media&token=95b07262-36db-4aa3-9f24-ec461d905591",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nameDriver,
                              style: const TextStyle(fontSize: 19, color: Colors.grey),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              carDetailsDriver,
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 19),
                    const Divider(
                      height: 1,
                      color: Colors.white70,
                      thickness: 1,
                    ),
                    const SizedBox(height: 19),

                    // car driver button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse("tel://$phoneNumberDriver"));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(width: 1, color: Palette.white),
                                ),
                                child: Icon(
                                  Icons.phone,
                                  color: Palette.white,
                                ),
                              ),
                              const SizedBox(height: 11),
                              const Text(
                                "Call",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
