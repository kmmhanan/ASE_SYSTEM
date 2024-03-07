import 'dart:async';

import 'package:citytaxi/components/progress_dialog.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/trip_details.dart';
import 'package:citytaxi/screens/driver_screen/new_trip_page.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:citytaxi/utils/methods/common_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationDialog extends StatefulWidget {
  TripDetails? tripDetailsInfo;
  NotificationDialog({super.key, this.tripDetailsInfo});

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  String tripRequestStatus = "";
  CommonMethods cMethods = CommonMethods();

  cancelNotificationDialogAfter20Sec() {
    const oneTickPerSecond = Duration(seconds: 1);
    var timerCountDown = Timer.periodic(oneTickPerSecond, (timer) {
      driverTripRequestTimeOut = driverTripRequestTimeOut - 1;

      if (tripRequestStatus == "accepted") {
        timer.cancel();
        driverTripRequestTimeOut = 20;
      }

      if (driverTripRequestTimeOut == 0) {
        Navigator.pop(context);
        timer.cancel();
        driverTripRequestTimeOut = 20;
        audioPlayer.stop();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cancelNotificationDialogAfter20Sec();
  }

  checkAvailabilityOfTripRequest(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Please Wait...",
            ));

// get the new trip status from db
    DatabaseReference driverTripStatusRef = FirebaseDatabase.instance.ref().child("drivers").child(FirebaseAuth.instance.currentUser!.uid).child("newTripStatus");

    await driverTripStatusRef.once().then((snap) {
      Navigator.pop(context); // closing notification dialog
      Navigator.pop(context); // closing please wat progress dialog

      String newTripStatusValue = "";
      if (snap.snapshot.value != null) {
        newTripStatusValue = snap.snapshot.value.toString();
      } else {
        Fluttertoast.showToast(msg: 'Trip Request Not Found');
      }
      //
      if (newTripStatusValue == widget.tripDetailsInfo!.tripID) {
        driverTripStatusRef.set("accepted");

        //disable homepage location updates
        cMethods.turnOffLocationUpdatesForHomePage();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTripPage(newTripDetailsInfo: widget.tripDetailsInfo),
            ));
      } else if (newTripStatusValue == "cancelled") {
        Fluttertoast.showToast(msg: 'Trip Request has been Cancelled by user');
      } else if (newTripStatusValue == "timeout") {
        Fluttertoast.showToast(msg: 'Trip Request Time Out');
      } else {
        Fluttertoast.showToast(msg: 'Trip Request Removed. Not Found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.black54,
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Image.asset("assets/logo/images/blackCar.png", width: 140),

            // title
            const Text('NEW TRIP REQUEST',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey,
                )),
            SizedBox(height: 20),

            Divider(height: 1, color: Palette.white, thickness: 1),

            SizedBox(height: 10),

            // pick up and drop off
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // pickup
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/logo/icons/destination-green.png",
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(width: 18),
                      Expanded(
                          child: Text(
                        widget.tripDetailsInfo!.pickupAddress.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 15),
                  // drop off
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/logo/icons/destination-red.png",
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(width: 18),
                      Expanded(
                          child: Text(
                        widget.tripDetailsInfo!.dropOffAddress.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(height: 1, color: Palette.white, thickness: 1),

            //  cancel button, accept button
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // cancel button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        audioPlayer.stop();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                      child: Text(
                        "DECLINE",
                        style: TextStyle(color: Palette.white),
                      ),
                    ),
                  ),

                  // ACCEPT button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        audioPlayer.stop();
                        setState(() {
                          tripRequestStatus = "accepted";
                        });

                        checkAvailabilityOfTripRequest(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: Text("ACCEPT", style: TextStyle(color: Palette.white)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
