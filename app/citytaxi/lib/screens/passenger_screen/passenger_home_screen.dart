import 'dart:async';
import 'dart:convert';

import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/home_dropdown.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/aboutus_screen.dart';
import 'package:citytaxi/screens/passenger_screen/nearby_drivers.dart';
import 'package:citytaxi/screens/profile_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PHomeScreen extends StatefulWidget {
  const PHomeScreen({super.key});

  @override
  State<PHomeScreen> createState() => _PHomeScreenState();
}

class _PHomeScreenState extends State<PHomeScreen> {
  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  late Position currenctPositionOfUser;

// theme path in json
  void updateMapTheme(GoogleMapController controller) {
    getJsonFileFromThemes("themes/night_style.json").then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String mapStylePath) async {
    ByteData byteData = await rootBundle.load(mapStylePath);
    var list = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  setGoogleMapStyle(String googleMapStyle, GoogleMapController controller) {
    controller.setMapStyle(googleMapStyle);
  }

  
  // getCurrentLiveLocationOfUser()async {
  //   Position positionOfUser = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  //   currenctPositionOfUser = positionOfUser;

  //   LatLng positionOfUserInLatLng  =  LatLng(currenctPositionOfUser.latitude, currenctPositionOfUser.longitude);
  
  //   CameraPosition cameraPosition = CameraPosition(target:positionOfUserInLatLng, zoom:15);
  //   controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  // }

  bool isDropdownVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Palette.mainColor60,
        toolbarHeight: 56,
        elevation: 0,
        title: Text(
          'Search Vehicle - Start A Ride',
          style: Theme.of(context).textTheme.normal18,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDropdownVisible = !isDropdownVisible;
              });
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),

      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;
              googleMapCompleterController.complete(mapController);

              // black theme google map
              updateMapTheme(controllerGoogleMap!);

          //    getCurrentLiveLocationOfUser();
            },
          ),
          SizedBox(
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
                const SizedBox(height: 56),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Palette.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Palette.white),
                        decoration: InputDecoration(
                          labelText: 'PICKUP',
                          labelStyle: TextStyle(color: Palette.white),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.white),
                          ),
                        ),
                        cursorColor: Palette.white,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                      ),
                      const SizedBox(height: 48),
                      TextFormField(
                        style: TextStyle(color: Palette.white),
                        decoration: InputDecoration(
                          labelText: 'DROP-OFF',
                          labelStyle: TextStyle(color: Palette.white),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.white),
                          ),
                        ),
                        cursorColor: Palette.white,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                      ),
                      const SizedBox(height: 64),
                      FillButton(
                        onTapped: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PNearDrivers(),
                            ),
                          );
                        },
                        text: 'Search',
                        color: Palette.mainColor30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                    const HomeDropdown(
                      name: 'Signout',
                      icon: Icons.exit_to_app_rounded,
                      goTo: WelcomeScreen(),
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
