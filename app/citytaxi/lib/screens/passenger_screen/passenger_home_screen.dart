import 'dart:async';
import 'dart:convert';

import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/home_dropdown.dart';
import 'package:citytaxi/components/progress_dialog.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/direction_details.dart';
import 'package:citytaxi/screens/aboutus_screen.dart';
import 'package:citytaxi/screens/passenger_screen/nearby_drivers.dart';
import 'package:citytaxi/screens/passenger_screen/search_destination.dart';
import 'package:citytaxi/screens/profile_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/utils/appInfo/app_info.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:citytaxi/utils/global/trip_variable.dart';
import 'package:citytaxi/utils/methods/common_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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
  // bool isDrawerOpened = true;
  bool isDefaultScreen = true;

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
      markerId: MarkerId("pickUpPointMarkerID"),
      position: pickupGeoGraphicCoOrdinates,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: pickUpLocation.placeName, snippet: "Pickup Location"),
    );

    Marker dropOffDestinationPointMarker = Marker(
      markerId: MarkerId("dropOffDestinationPointMarkerID"),
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
      circleId: CircleId('pickupCircleID'),
      strokeColor: Colors.pink, // border
      strokeWidth: 4,
      radius: 14,
      center: pickupGeoGraphicCoOrdinates,
      fillColor: Colors.pink,
    );
    Circle dropOffDestinationPointCircle = Circle(
      circleId: CircleId('dropOffDestinationCircleID'),
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

  @override
  Widget build(BuildContext context) {
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
                                    SizedBox(width: 10),
                                    // km
                                    Text(
                                      (tripDirectionDetailsInfo != null) ? tripDirectionDetailsInfo!.distanceTextString! : "",
                                      style: Theme.of(context).textTheme.normal16.copyWith(color: Palette.white),
                                    ),
                                  ],
                                ),

                                // vehicle pic
                                InkWell(
                                  onTap: () {},
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
          )
        ],
      ),
    );
  }
}
