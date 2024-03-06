import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  String currentDriverTotalTripsCompleted = "";

  getCurrentDriverTotalNumberOfTripsCompleted() async {
    DatabaseReference tripsRequestRef = FirebaseDatabase.instance.ref().child("tripRequests");

    await tripsRequestRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        Map<dynamic, dynamic> allTripsMap = snap.snapshot.value as Map;
        int allTripsLength = allTripsMap.length;

        List<String> tripsCompletedByCurrentDriver = [];

        allTripsMap.forEach((key, value) {
          if (value["status"] != null) {
            if (value["status"] == "ended") {
              if (value["driverID"] == FirebaseAuth.instance.currentUser!.uid) {
                tripsCompletedByCurrentDriver.add(key);
              }
            }
          }
        });

        setState(() {
          currentDriverTotalTripsCompleted = tripsCompletedByCurrentDriver.length.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      body: Center(
        // outside container
        child: Container(
          width: 300,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 24,
            bottom: MediaQuery.of(context).padding.bottom + 48,
          ),
          child: Center(
            // inside white container
            child: Container(
              width: double.infinity,
              //    height: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // close icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Positioned(
                        right: -8,
                        top: -8,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // total trips
                  Column(
                    children: [
                      Image.asset(
                        'assets/logo/images/ride2.png',
                        // width: 200,
                      ),
                      Text(
                        "Total Trips: ",
                        style: Theme.of(context).textTheme.bold18.copyWith(
                              color: Palette.black,
                            ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        currentDriverTotalTripsCompleted,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.normal32.copyWith(color: Palette.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
