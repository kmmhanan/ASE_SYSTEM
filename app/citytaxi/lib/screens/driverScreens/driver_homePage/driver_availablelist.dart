import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driverScreens/driver_homePage/d_homePage.dart';
import 'package:citytaxi/screens/driverScreens/driver_homePage/ride_details.dart';
import 'package:citytaxi/screens/driverScreens/widgets/listcard_widget.dart';
import 'package:flutter/material.dart'; 

import '../../../constants/palette.dart';

class DriverList extends StatelessWidget {
  const DriverList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
        //  automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Palette.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DHomePage()));
            }),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Palette.black.withOpacity(0.3),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 18),
            Center(child: Text('Hire List', style: Theme.of(context).textTheme.normal16)),
            const SizedBox(height: 18),
            const SingleChildScrollView(
              child: Column(
                children: [
                  ListCardWidget(
                    fromAddress: '23/2, Athapttu Mawatha, Dehiwala ',
                    toAddress: '32, Dr. Pons Rd, Bambalpitiya ',
                    distance: '45km',
                  ),
                  ListCardWidget(
                    fromAddress: '23/2, Athapttu Mawatha, Dehiwala, Dr. Pons Rd, Bambalpitiya, Athapttu Mawatha, Dehiwala ',
                    toAddress: 'Airport and Aviation Services (Sri Lanka) (Private) Limited. Bandaranaike International Airport, Katunayake, Sri Lanka.',
                    distance: '45km',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white)),
                child: Center(
                  child: Text('Cancel', style: Theme.of(context).textTheme.normal16),
                ),
              ),
            ),
            const SizedBox(height: 22),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RideDetailsPage()));
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(color: Palette.mainColor30, borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text('Pick Up', style: Theme.of(context).textTheme.normal16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
