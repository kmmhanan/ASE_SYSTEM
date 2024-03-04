import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";

String userEmail = "";

String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;

String googleMapKey = "AIzaSyDWVggAL03kp1_-rbaBUL0KQvMnNBffn5U"; //andriod

String serverKeyFCM = "key=AAAAVN2kvRc:APA91bGrhdvlPX6gy2zRR8OYz0jXJjG5BvF_EecFnUP0xcryZLnoHKAMKzXJi10Ln3GcoLzEyw_UHPQSb0OA2PWJGj9fbRgM6leRYwZ0McW6vcWolRBcqg2IdpENiaR3VPc-nq7yS1R0";

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

StreamSubscription<Position>? positionStreamDHomePage;

int driverTripRequestTimeOut = 20;

final audioPlayer = AssetsAudioPlayer();
