import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/utils/appInfo/app_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  String driverEarnings = "";

  getTotalEarningsOfCurrentDrivers() async {
    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");

    await driversRef.child(FirebaseAuth.instance.currentUser!.uid).once().then((snap) {
      if ((snap.snapshot.value as Map)["earnings"] != null) {
        setState(() {
          driverEarnings = ((snap.snapshot.value as Map)["earnings"]).toString();
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
                  const SizedBox(height: 10),
                  // total trips
                  Column(
                    children: [
                      Image.asset(
                        'assets/logo/images/ride2.png',
                        // width: 200,
                      ),
                      Text(
                        "Total Earnings: ",
                        style: Theme.of(context).textTheme.bold18.copyWith(
                              color: Palette.black,
                            ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                         "LKR: $driverEarnings",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.normal32.copyWith(color: Palette.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
