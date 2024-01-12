import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driverScreens/ride_processing.dart';
import 'package:citytaxi/components/customcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RideDetailsPage extends StatelessWidget {
  const RideDetailsPage({super.key});

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
              Navigator.pop(context);
            }),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      body: Center(
        child: Image.asset(
          'assets/logo/images/ridedetails.png',
          height: 250,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: ShapeDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ))),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: Text('Ride Details',
                    style: Theme.of(context).textTheme.normal16)),
            const SizedBox(height: 18),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CustomCard(label: 'Name', value: 'Dilini Buddhika'),
                    SizedBox(height: 12),
                    CustomCard(label: 'Contact', value: '+94 77 123 4567'),
                    SizedBox(height: 12),
                    CustomCard(
                        label: 'From',
                        value: '23/2, Athapttu Mawatha, Dehiwala'),
                    SizedBox(height: 12),
                    CustomCard(
                        label: 'To', value: '32, Dr. Pons Rd, Bambalpitiya'),
                    SizedBox(height: 12),
                    CustomCard(label: 'Distance', value: '45km'),
                    SizedBox(height: 12),
                    CustomCard(label: 'Time', value: '-'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {},
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white)),
                child: Center(
                  child:
                      Text('Call', style: Theme.of(context).textTheme.normal16),
                ),
              ),
            ),
            const SizedBox(height: 22),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RideProcessingScreen()));
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                    color: Palette.mainColor30,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text('Waiting',
                      style: Theme.of(context).textTheme.normal16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
