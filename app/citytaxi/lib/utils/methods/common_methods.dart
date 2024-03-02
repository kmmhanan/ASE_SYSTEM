import 'dart:convert';

import 'package:citytaxi/models/address_model.dart';
import 'package:citytaxi/models/direction_details.dart';
import 'package:citytaxi/utils/appInfo/app_info.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CommonMethods {
  checkConnectivity(context) async {
    // wifi, sim data
    var connectionResult = await Connectivity().checkConnectivity();

    if (connectionResult != ConnectivityResult.mobile && connectionResult != ConnectivityResult.wifi) {
      if (!context.mounted) return;
      Fluttertoast.showToast(msg: "Your Internet is not Working. Check your connection and Try Again");
    }
  }

  static sendRequestToAPI(String apiUrl) async {
    http.Response responseFromAPI = await http.get(Uri.parse(apiUrl));

    try {
      if (responseFromAPI.statusCode == 200) {
        String dataFromApi = responseFromAPI.body;
        var dataDecoded = jsonDecode(dataFromApi);
        return dataDecoded;
      } else {
        return "error";
      }
    } catch (errorMsg) {
      return "error";
    }
  }

  // reserse GeoCoding
  static Future<String> convertGeoGraphicCoorIntoHumanReadableAddress(Position position, BuildContext context) async {
    String humanReadableAddress = "";

    String apiGeoCodingUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleMapKey";

    var responseFromAPI = await sendRequestToAPI(apiGeoCodingUrl);

    if (responseFromAPI != "error") {
      humanReadableAddress = responseFromAPI["results"][0]["formatted_address"];

      AddressModel model = AddressModel();
      model.humanReadableAddress = humanReadableAddress;
      model.longitudePosition = position.longitude;
      model.latitudePosition = position.latitude;

      Provider.of<AppInfo>(context, listen: false).updatePickUpLocation(model);
    }
    return humanReadableAddress;
  }

  // directions api
  static Future<DirectionDetails?> getDrectionDetailsFromAPI(LatLng source, LatLng destination) async {
    String urlDrectionAPI = "https://maps.googleapis.com/maps/api/directions/json?destination=${destination.latitude},${destination.longitude}&origin=${source.latitude},${source.longitude}&mode=driving&key=$googleMapKey";

    var responseFromDirectionAPI = await sendRequestToAPI(urlDrectionAPI);

    if (responseFromDirectionAPI == "error") {
      return null;
    }
    DirectionDetails detailsModel = DirectionDetails();
    detailsModel.distanceTextString = responseFromDirectionAPI["routes"][0]["legs"][0]["distance"]["text"]; // json format
    detailsModel.distanceValueDigits = responseFromDirectionAPI["routes"][0]["legs"][0]["distance"]["value"];

    detailsModel.durationTextString = responseFromDirectionAPI["routes"][0]["legs"][0]["duration"]["text"];
    detailsModel.durationValurDigits = responseFromDirectionAPI["routes"][0]["legs"][0]["duration"]["value"];

    detailsModel.encodedPoints = responseFromDirectionAPI["routes"][0]["overview_polyline"]["points"];

    return detailsModel;
  }

  // calculate fare ammout
  static calculateFareAmount(DirectionDetails directionDetails) {
    double distancePerKmAmount = 60; // 160
    double durationPerMinuteAmount = 20; // 120
    double baseFareAmount = 100; // 400

    double totalDistanceTravelFareAmount = (directionDetails.distanceValueDigits! / 1000) * distancePerKmAmount;
    double totalDurationSpendFareAmount = (directionDetails.durationValurDigits! / 60) * durationPerMinuteAmount;

    double overallAllTotalFareAmount = baseFareAmount + totalDistanceTravelFareAmount + totalDurationSpendFareAmount;

    return overallAllTotalFareAmount.toStringAsFixed(0);
  }
}
