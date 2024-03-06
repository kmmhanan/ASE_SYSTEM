import 'package:citytaxi/components/progress_dialog.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/address_model.dart';
import 'package:citytaxi/models/prediction_model.dart';
import 'package:citytaxi/utils/appInfo/app_info.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:citytaxi/utils/methods/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PredictionPlaceUI extends StatefulWidget {
  PredictionModel? predictedPlaceData;
  PredictionPlaceUI({super.key, this.predictedPlaceData});

  @override
  State<PredictionPlaceUI> createState() => _PredictionPlaceUIState();
}

class _PredictionPlaceUIState extends State<PredictionPlaceUI> {
// place details - places API
  fetchClickedPlaceDetails(String placeID) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ProgressDialog(message: "Getting Details"),
    );
    // Fluttertoast.showToast(msg: "Getting details...");

    String urlPlaceDetalisAPi = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$googleMapKey";

    var responseFromPlaceDetailsAPI = await CommonMethods.sendRequestToAPI(urlPlaceDetalisAPi);

    Navigator.pop(context);

    if (responseFromPlaceDetailsAPI == "error") {
      return;
    }
    if (responseFromPlaceDetailsAPI["status"] == "OK") {
      AddressModel dropOffLocation = AddressModel();

      dropOffLocation.placeName = responseFromPlaceDetailsAPI["result"]["name"];
      dropOffLocation.latitudePosition = responseFromPlaceDetailsAPI["result"]["geometry"]["location"]["lat"];
      dropOffLocation.longitudePosition = responseFromPlaceDetailsAPI["result"]["geometry"]["location"]["lng"];
      dropOffLocation.placeID = placeID;

      Provider.of<AppInfo>(context, listen: false).updateDropOfLocation(dropOffLocation);

      Navigator.pop(context, "placeSelected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          fetchClickedPlaceDetails(widget.predictedPlaceData!.place_id.toString());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.white,
          shadowColor: Palette.darkgrey,
        ),
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.share_location,
                    color: Palette.darkgrey,
                  ),
                  SizedBox(width: 13),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.predictedPlaceData!.main_text.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.normal16.copyWith(color: Palette.black),
                      ),
                      SizedBox(height: 3),
                      Text(
                        widget.predictedPlaceData!.secondary_text.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.normal13.copyWith(
                              color: Palette.darkgrey,
                            ),
                      ),
                    ],
                  ))
                ],
              ),
              SizedBox(height: 5),
            ],
          ),
        ));
  }
}
