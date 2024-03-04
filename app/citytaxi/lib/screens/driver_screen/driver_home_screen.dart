import 'dart:async';
import 'dart:convert';

import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/home_dropdown.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/aboutus_screen.dart';
import 'package:citytaxi/screens/driver_screen/available_hire.dart';
import 'package:citytaxi/screens/pushNotification/push_notification_system.dart';
import 'package:citytaxi/screens/profile_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DHomeScreen extends StatefulWidget {
  const DHomeScreen({super.key});

  @override
  State<DHomeScreen> createState() => _DHomeScreenState();
}

class _DHomeScreenState extends State<DHomeScreen> {
  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  Position? currenctPositionOfUser;
  bool isDropdownVisible = false;
  // bool isAvailable = true;
  Color colorToShow = Palette.green;
  String titleToShow = "Available";
  bool isDriverAvailable = false;
  DatabaseReference? newTripRequestReference;

// theme path in json
  void updateMapTheme(GoogleMapController controller) {
    getJsonFileFromThemes("themes/retro_style.json").then((value) => setGoogleMapStyle(value, controller));
  }

  // make it into byte form
  Future<String> getJsonFileFromThemes(String mapStylePath) async {
    ByteData byteData = await rootBundle.load(mapStylePath);
    var list = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  setGoogleMapStyle(String googleMapStyle, GoogleMapController controller) {
    controller.setMapStyle(googleMapStyle);
  }

  //get the drivers current location
  getCurrentLiveLocationOfDriver() async {
    Position positionOfUser = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currenctPositionOfUser = positionOfUser;

    LatLng positionOfUserInLatLng = LatLng(currenctPositionOfUser!.latitude, currenctPositionOfUser!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: positionOfUserInLatLng, zoom: 18);
    //display the current location of the user
    controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // go online now
  Available() {
    // all drivers who are available for new trip requests
    Geofire.initialize("onlineDrivers");

    // initialize set location
    Geofire.setLocation(
      FirebaseAuth.instance.currentUser!.uid, // driver id
      currenctPositionOfUser!.latitude,
      currenctPositionOfUser!.longitude,
    );

    newTripRequestReference = FirebaseDatabase.instance.ref().child("drivers").child(FirebaseAuth.instance.currentUser!.uid).child("newTripStatus");
    newTripRequestReference!.set("waiting");

    newTripRequestReference!.onValue.listen((event) {});
  }

  setAndGetLocationUpdates() {
    positionStreamDHomePage = Geolocator.getPositionStream().listen((Position position) {
      currenctPositionOfUser = position;

      // live location sharing if the driver is online
      if (isDriverAvailable) {
        Geofire.setLocation(
          FirebaseAuth.instance.currentUser!.uid,
          currenctPositionOfUser!.latitude,
          currenctPositionOfUser!.longitude,
        );
      }
      LatLng positionLatLng = LatLng(
        position.latitude,
        position.longitude,
      );
      //
      controllerGoogleMap!.animateCamera(CameraUpdate.newLatLng(positionLatLng));
    });
  }

// go offline now
  Busy() {
    //stop sharing live location updates
    Geofire.removeLocation(FirebaseAuth.instance.currentUser!.uid);

    // stop listening to the newTripStatus
    newTripRequestReference!.onDisconnect();
    newTripRequestReference!.remove();
    newTripRequestReference = null;
  }

  initializePushNotificationSystem() {
    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.startListeningForNewNotification(context);
  }

  @override
  void initState() {
    super.initState();

    initializePushNotificationSystem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Palette.mainColor60,
        toolbarHeight: 56,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Drive More   -   Earn More',
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
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              googleMapCompleterController.complete(mapController);
              controllerGoogleMap = mapController;

              // black theme google map
              updateMapTheme(controllerGoogleMap!);

              // live location
              getCurrentLiveLocationOfDriver();
            },
          ),

          //
          Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 56,
            padding: EdgeInsets.only(
              left: 16,
              top: MediaQuery.of(context).padding.top + 24,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
            ),
            child: Column(
              children: [
                // old ui
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 16,
                //     vertical: 24,
                //   ),
                //   decoration: BoxDecoration(
                //     color: Palette.black.withOpacity(0.3),
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   child: Column(
                //     children: [
                //       Text(
                //         'Drive More, Earn More.',
                //         style: Theme.of(context).textTheme.bold18,
                //       ),
                //       const SizedBox(height: 16),
                //       ClipRRect(
                //         borderRadius: BorderRadius.circular(16),
                //         child: Image.asset(
                //           'assets/logo/images/map.png',
                //           height: 300,
                //           width: double.infinity,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //       const SizedBox(height: 16),
                //       Text(
                //         'Drive Safe... 😊',
                //         style: Theme.of(context).textTheme.normal16,
                //       ),
                //     ],
                //   ),
                // ),

                // go online, offline
                const Expanded(child: SizedBox()),

                // if (!isAvailable)
                //   BorderButton(
                //       onTapped: () {
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => const AvailableHire()));
                //       },
                //       text: 'View Hire List'),
                // const SizedBox(height: 16),
                // available
                FillButton(
                  onTapped: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                          ),
                          height: 240,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                            child: Column(
                              children: [
                                SizedBox(height: 11),
                                Text(
                                  (!isDriverAvailable) ? "Available" : "Busy",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.normal18,
                                ),
                                SizedBox(height: 21),
                                Text(
                                  (!isDriverAvailable) ? "You are about to go online, you will be become available to receieve trip requests from Users" : "You are about to go offline, you will stop receiving new trip requests from users",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.normal16.copyWith(color: Colors.white70),
                                ),
                                SizedBox(height: 25),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "BACK",
                                            style: Theme.of(context).textTheme.normal13.copyWith(color: Palette.black),
                                          )),
                                    ),
                                    SizedBox(width: 16),
                                    // confirm
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (!isDriverAvailable) {
                                              // go online
                                              Available();

                                              // get driver location updates
                                              setAndGetLocationUpdates();

                                              Navigator.pop(context);

                                              setState(() {
                                                colorToShow = Palette.red;
                                                titleToShow = "Busy";
                                                isDriverAvailable = true;
                                              });
                                            } else {
                                              // go offline
                                              Busy();
                                              Navigator.pop(context);

                                              setState(() {
                                                colorToShow = Palette.green;
                                                titleToShow = "Available";
                                                isDriverAvailable = false;
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: (titleToShow == "Available") ? Palette.green : Palette.red,
                                          ),
                                          child: Text(
                                            "CONFIRM",
                                            style: Theme.of(context).textTheme.normal13.copyWith(color: Palette.black),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    // setState(() {
                    //   isAvailable = !isAvailable;
                    // });
                  },
                  text: titleToShow,
                  color: colorToShow,
                ),
                const SizedBox(height: 16),
                Text(
                  'Change Status',
                  style: Theme.of(context).textTheme.normal16.copyWith(color: Palette.black),
                )
              ],
            ),
          ),

          // profile drawer
          Positioned(
            top: 0.0,
            right: 16.0,
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
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5.0,
                    ),
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

                    // Add more options as needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
