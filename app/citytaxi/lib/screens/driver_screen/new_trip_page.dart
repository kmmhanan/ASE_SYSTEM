import 'dart:async';

import 'package:citytaxi/components/progress_dialog.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/models/trip_details.dart';
import 'package:citytaxi/screens/driver_screen/widgets/payment_dialog.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:citytaxi/utils/methods/common_methods.dart';
import 'package:citytaxi/utils/methods/map_theme_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NewTripPage extends StatefulWidget {
  TripDetails? newTripDetailsInfo;
  NewTripPage({super.key, this.newTripDetailsInfo});

  @override
  State<NewTripPage> createState() => _NewTripPageState();
}

class _NewTripPageState extends State<NewTripPage> {
  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  MapThemeMethods themeMethods = MapThemeMethods();
  double googleMapPaddingFromBottom = 0;
  List<LatLng> coordinatesPolylineLatLngList = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> markerSet = Set<Marker>();
  Set<Circle> circleSet = Set<Circle>();
  Set<Polyline> polyLineSet = Set<Polyline>();
  BitmapDescriptor? carMarkerIcon;
  bool directionRequested = false;
  String statusOfTrip = "accepted";
  String durationText = "", distanceText = "";
  String buttonTitleText = "ARRIVED";
  Color buttonColor = Colors.indigoAccent;
  CommonMethods cMethods = CommonMethods();

  makeMarker() {
    if (carMarkerIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context, size: const Size(2, 2));

      BitmapDescriptor.fromAssetImage(configuration, "assets/logo/icons/tracking1.png").then((valueIcon) {
        carMarkerIcon = valueIcon;
      });
    }
  }

//go current position to destnation
  obtainDirectionAndDrawRoute(sourceLocationLatLng, destinationLocationLatLng) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(message: "Please Wait..."),
    );

    var tripDetailsInfo = await CommonMethods.getDrectionDetailsFromAPI(
      sourceLocationLatLng,
      destinationLocationLatLng,
    );
    Navigator.pop(context);

    // draw polyline
    PolylinePoints pointsPolyline = PolylinePoints();
    List<PointLatLng> latLngPoints = pointsPolyline.decodePolyline(tripDetailsInfo!.encodedPoints!);

    coordinatesPolylineLatLngList.clear();

    if (latLngPoints.isNotEmpty) {
      latLngPoints.forEach((PointLatLng pointLatLng) {
        coordinatesPolylineLatLngList.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    // draw polyline
    polyLineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        polylineId: const PolylineId("routeID"),
        color: Colors.amber,
        points: coordinatesPolylineLatLngList,
        jointType: JointType.round,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polyLineSet.add(polyline);
    });

    // fit the polyline on google map
    LatLngBounds boundsLatLng;

    if (sourceLocationLatLng.latitude > destinationLocationLatLng.latitude && sourceLocationLatLng.longitude > destinationLocationLatLng.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: destinationLocationLatLng,
        northeast: sourceLocationLatLng,
      );
    } else if (sourceLocationLatLng.longitude > destinationLocationLatLng.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(sourceLocationLatLng.latitude, destinationLocationLatLng.longitude),
        northeast: LatLng(destinationLocationLatLng.latitude, sourceLocationLatLng.longitude),
      );
    } else if (sourceLocationLatLng.latitude > destinationLocationLatLng.latitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(destinationLocationLatLng.latitude, sourceLocationLatLng.longitude),
        northeast: LatLng(sourceLocationLatLng.latitude, destinationLocationLatLng.longitude),
      );
    } else {
      boundsLatLng = LatLngBounds(
        southwest: sourceLocationLatLng,
        northeast: destinationLocationLatLng,
      );
    }

    controllerGoogleMap!.animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 72));

    // add marker
    Marker sourceMarker = Marker(
      markerId: const MarkerId("sourceID"),
      position: sourceLocationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    Marker destinationMarker = Marker(
      markerId: const MarkerId("sourceID"),
      position: destinationLocationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );

    setState(() {
      markerSet.add(sourceMarker);
      markerSet.add(destinationMarker);
    });

    // add circle
    Circle sourceCircle = Circle(
      circleId: const CircleId("sourceCircleID"),
      strokeColor: Colors.orange,
      strokeWidth: 4,
      radius: 14,
      center: sourceLocationLatLng,
      fillColor: Colors.green,
    );

    Circle destinationCircle = Circle(
      circleId: const CircleId("destinationCircleID"),
      strokeColor: Colors.green,
      strokeWidth: 4,
      radius: 14,
      center: destinationLocationLatLng,
      fillColor: Colors.orange,
    );

    setState(() {
      circleSet.add(sourceCircle);
      circleSet.add(destinationCircle);
    });
  }

//
  getLiveLocationUpdatesOfDrivers() {
    LatLng lastPositionLatLng = const LatLng(0, 0);

    positionStreamNewTripPage = Geolocator.getPositionStream().listen((Position positionDriver) {
      driverCurrentPosition = positionDriver;

      LatLng driverCurrentPositionLatLng = LatLng(driverCurrentPosition!.latitude, driverCurrentPosition!.longitude);

      Marker carMarker = Marker(
        markerId: const MarkerId("carMarkerID"),
        position: driverCurrentPositionLatLng,
        icon: carMarkerIcon!,
        infoWindow: const InfoWindow(title: "My Location"),
      );

      // driver moving camera position
      setState(() {
        CameraPosition cameraPosition = CameraPosition(target: driverCurrentPositionLatLng, zoom: 16);
        controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        // remove marker from last location nd update when driver moving to destination
        markerSet.removeWhere((element) => element.markerId.value == "carMarkerID");
        markerSet.add(carMarker);
      });

      lastPositionLatLng = driverCurrentPositionLatLng;

      //update the trip details information
      updateTripDetailsInformation();

      // update driver location to tripRequest
      Map updateLocationOfDriver = {
        "latitude": driverCurrentPosition!.latitude,
        "longitude": driverCurrentPosition!.longitude,
      };
      FirebaseDatabase.instance.ref().child("tripRequests").child(widget.newTripDetailsInfo!.tripID!).child("driverLocation").set(updateLocationOfDriver);
    });
  }

  updateTripDetailsInformation() async {
    if (!directionRequested) {
      directionRequested = true;

      if (driverCurrentPosition == null) {
        return;
      }

      var driverLocationLatLng = LatLng(driverCurrentPosition!.latitude, driverCurrentPosition!.longitude);

      LatLng dropOffDestinationLocationLatLng;
      // driver accept. to the users location
      if (statusOfTrip == "accepted") {
        dropOffDestinationLocationLatLng = widget.newTripDetailsInfo!.pickUpLatLng!;
      } else {
        dropOffDestinationLocationLatLng = widget.newTripDetailsInfo!.dropOffLatLng!;
      }

      var directionDetailsInfor = await CommonMethods.getDrectionDetailsFromAPI(driverLocationLatLng, dropOffDestinationLocationLatLng);

      if (directionDetailsInfor != null) {
        directionRequested = false;
        setState(() {
          durationText = directionDetailsInfor.durationTextString!;
          distanceText = directionDetailsInfor.distanceTextString!;
        });
      }
    }
  }

  endTripNow() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(message: "Please Wait..."),
    );

    // driver current location  - driver at the destination
    var driverCurrentLocationLatLng = LatLng(
      driverCurrentPosition!.latitude,
      driverCurrentPosition!.longitude,
    );

    var directionDetailsEndTripInfo = await CommonMethods.getDrectionDetailsFromAPI(
      widget.newTripDetailsInfo!.pickUpLatLng!, // pickup
      driverCurrentLocationLatLng, // destination
    );

    Navigator.pop(context);

    String fareAmount = (CommonMethods.calculateFareAmount(directionDetailsEndTripInfo!)).toString();

    await FirebaseDatabase.instance.ref().child("tripRequests").child(widget.newTripDetailsInfo!.tripID!).child("fareAmount").set(fareAmount);

    await FirebaseDatabase.instance.ref().child("tripRequests").child(widget.newTripDetailsInfo!.tripID!).child("status").set("ended");

    positionStreamNewTripPage!.cancel();

    // dialog for collecting fare amount
    displayPlaymentDialog(fareAmount);

    // save the fare amount to driver total earnings
    saveFareAmountToDriverTotalEarning(fareAmount);
  }

  displayPlaymentDialog(fareAmount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PaymentDialog(fareAmount: fareAmount),
    );
  }

  saveFareAmountToDriverTotalEarning(String fareAmount) async {
    DatabaseReference driverEarningRef = FirebaseDatabase.instance.ref().child("drivers").child(FirebaseAuth.instance.currentUser!.uid).child("earnings");

    await driverEarningRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        double previousTotalEarnings = double.parse(snap.snapshot.value.toString());
        double fareAmountForTrip = double.parse(fareAmount);

        double newTotalEarnings = previousTotalEarnings + fareAmountForTrip;

        driverEarningRef.set(newTotalEarnings);
      } else {
        driverEarningRef.set(fareAmount);
      }
    });
  }

  saveDriverDataToTripInfo() async {
    Map<String, dynamic> driverDataMap = {
      "status": "accepted",
      "driverID": FirebaseAuth.instance.currentUser!.uid,
      "driverName": driverName,
      "driverPhone": driverPhone,
      "carDetails": "$carModel - $carNumber - $carType",
    };

    Map<String, dynamic> driverCurrentLocation = {
      "latitude": driverCurrentPosition!.latitude.toString(),
      "longitude": driverCurrentPosition!.longitude.toString(),
    };

    await FirebaseDatabase.instance.ref().child("tripRequests").child(widget.newTripDetailsInfo!.tripID!).update(driverDataMap);

    await FirebaseDatabase.instance.ref().child("tripRequests").child(widget.newTripDetailsInfo!.tripID!).child("driverLocation").update(driverCurrentLocation);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveDriverDataToTripInfo();
  }

  @override
  Widget build(BuildContext context) {
    makeMarker();
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: googleMapPaddingFromBottom),
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: markerSet,
            circles: circleSet,
            polylines: polyLineSet,
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) async {
              googleMapCompleterController.complete(mapController);
              controllerGoogleMap = mapController;
              //   theme google map
              themeMethods.updateMapTheme(controllerGoogleMap!);

              setState(() {
                googleMapPaddingFromBottom = 262;
              });

              var driverCurrentLocationLatLng = LatLng(
                driverCurrentPosition!.latitude,
                driverCurrentPosition!.longitude,
              );

              var userPickUpLocationLatLng = widget.newTripDetailsInfo!.pickUpLatLng;

              await obtainDirectionAndDrawRoute(driverCurrentLocationLatLng, userPickUpLocationLatLng);

              // update live location
              getLiveLocationUpdatesOfDrivers();
            },
          ),

          // trip details
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(17), topLeft: Radius.circular(17)),
                  ),
                  height: 256,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // trip duration
                        Center(
                            child: Text(
                          "$durationText - $distanceText",
                          style: const TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                        const SizedBox(height: 5),
                        // user name- call user icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // username
                            Text(
                              widget.newTripDetailsInfo!.userName!,
                              style: TextStyle(color: Palette.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),

                            // call user icon
                            GestureDetector(
                              onTap: () {
                                launchUrl(
                                  Uri.parse("tel://${widget.newTripDetailsInfo!.userPhone.toString()}"),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.phone_android_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(color: Palette.white, thickness: 1, height: 1),
                        const SizedBox(height: 10),
                        // pickup icon and location
                        Row(
                          children: [
                            Image.asset(
                              "assets/logo/icons/destination-green.png",
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                                child: Text(
                              widget.newTripDetailsInfo!.pickupAddress.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 15),

                        // dropoff icon and location
                        Row(
                          children: [
                            Image.asset(
                              "assets/logo/icons/destination-red.png",
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                                child: Text(
                              widget.newTripDetailsInfo!.dropOffAddress.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 25),

                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              // arrived button
                              if (statusOfTrip == "accepted") {
                                setState(() {
                                  buttonTitleText = "START TRIP";
                                  buttonColor = Colors.green;
                                });

                                statusOfTrip = "arrived";

                                FirebaseDatabase.instance.ref().child("tripRequests").child(widget.newTripDetailsInfo!.tripID!).child("status").set("arrived");

                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) => ProgressDialog(message: "Please Wait..."),
                                );
                                await obtainDirectionAndDrawRoute(
                                  widget.newTripDetailsInfo!.pickUpLatLng,
                                  widget.newTripDetailsInfo!.dropOffLatLng,
                                );

                                Navigator.pop(context);
                              }
                              // start button
                              else if (statusOfTrip == "arrived") {
                                setState(() {
                                  buttonTitleText = "END TRIP";
                                  buttonColor = Colors.amber;
                                });
                                statusOfTrip = "ontrip";
                                FirebaseDatabase.instance.ref().child("tripRequests").child(widget.newTripDetailsInfo!.tripID!).child("status").set("ontrip");
                              }
                              // end trip button
                              else if (statusOfTrip == "ontrip") {
                                //
                                endTripNow();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            child: Text(
                              buttonTitleText,
                              style: TextStyle(color: Palette.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
