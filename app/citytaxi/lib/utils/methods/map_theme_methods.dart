import 'dart:convert'; 
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapThemeMethods{
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
}