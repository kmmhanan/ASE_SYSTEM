import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driverScreens/ride_completed.dart';
import 'package:citytaxi/components/customcard_widget.dart';
import 'package:flutter/material.dart';

class RidePaymentScreen extends StatelessWidget {
  const RidePaymentScreen({super.key});

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
          'assets/logo/images/payment.png',
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
                child: Text('Ride Processing',
                    style: Theme.of(context).textTheme.normal16)),
            const SizedBox(height: 50),
            Text(
              'Amount',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.normal16,
            ),
            Text(
              '245.67 Rs',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bold32,
            ),
            const SizedBox(height: 50),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CustomCard(label: 'Name', value: 'Dilini Buddhika'),
                    SizedBox(height: 12),
                    CustomCard(label: 'Contact', value: '+94 77 123 4567'),
                    SizedBox(height: 12),
                    CustomCard(label: 'Ride Time', value: '0hrs 34m'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RideCompleted()));
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                    color: Palette.green,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text('Payment Received',
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
