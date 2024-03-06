import 'package:citytaxi/components/custom_text_field.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/prediction_model.dart';
import 'package:citytaxi/screens/passenger_screen/widgets/prediction_place_ui.dart';
import 'package:citytaxi/utils/appInfo/app_info.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:citytaxi/utils/methods/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SearchDestinationPage extends StatefulWidget {
  const SearchDestinationPage({super.key});

  @override
  State<SearchDestinationPage> createState() => _SearchDestinationPageState();
}

class _SearchDestinationPageState extends State<SearchDestinationPage> {
  TextEditingController pickUptextEditingController = TextEditingController();
  TextEditingController destinationtextEditingController = TextEditingController();
  List<PredictionModel> dropOffPredictionsPlacesList = [];

  // google places API - place autocomplete
  searchLocation(String locationName) async {
    if (locationName.length > 1) {
      String apiPlacesUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$locationName&key=$googleMapKey&components=country:lk";

      var responseFromPlacesAPI = await CommonMethods.sendRequestToAPI(apiPlacesUrl);

      if (responseFromPlacesAPI == "error") {
        return;
      }
      if (responseFromPlacesAPI["status"] == "OK") {
        var predictionResultInJson = responseFromPlacesAPI["predictions"];
        // convert to normal format
        var predictionList = (predictionResultInJson as List).map((eachPlacePrediction) => PredictionModel.fromJson(eachPlacePrediction)).toList();
        setState(() {
          dropOffPredictionsPlacesList = predictionList;
        });

        // print("presictionResultInJson = " + predictionResultInJson.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String userAddress = Provider.of<AppInfo>(context, listen: false).pickUpLocation!.humanReadableAddress ?? "";

    pickUptextEditingController.text = userAddress;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // set drop off location container
            Container(
              color: Palette.mainColor60,
              child: Padding(
                padding: EdgeInsets.only(left: 24, top: 48, right: 24, bottom: 16),
                child: Column(
                  children: [
                    // icon button and title
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Palette.white,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Set Dropoff Location",
                            style: Theme.of(context).textTheme.normal18.copyWith(
                                  color: Palette.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                      ],
                    ), //
                    SizedBox(height: 2),

                    // pickup
                    Row(
                      children: [
                        Image.asset(
                          'assets/logo/icons/destination-green.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: CustomTextField(
                            label: 'Pick Up Address',
                            controller: pickUptextEditingController,
                          ),
                        )
                      ],
                    ),

                    // drop off
                    Row(
                      children: [
                        Image.asset(
                          'assets/logo/icons/destination-red.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: CustomTextField(
                            label: 'Drop Off Address',
                            controller: destinationtextEditingController,
                            onChanged: (inputText) {
                              searchLocation(inputText);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            // display prediction results for destination place
            (dropOffPredictionsPlacesList.length > 0)
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: PredictionPlaceUI(
                            predictedPlaceData: dropOffPredictionsPlacesList[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, index) => SizedBox(height: 2),
                      itemCount: dropOffPredictionsPlacesList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
