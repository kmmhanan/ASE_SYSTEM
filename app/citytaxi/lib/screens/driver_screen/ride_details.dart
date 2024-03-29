import 'package:citytaxi/components/baground_container.dart';
import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/driver_screen/ride_processing.dart';
import 'package:citytaxi/components/detailed_card.dart';
import 'package:flutter/material.dart';

class RideDetailsScreen extends StatelessWidget {
  const RideDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.pop(context);
      },
      widget: BagroundContainer(
        heading: 'Ride Details',
        bodyWidgets: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    // Need to change the image
                    'assets/logo/images/ridedetails.png',
                    height: 250,
                  ),
                ),
                const SizedBox(height: 16),
                const DetailedCard(),
                const SizedBox(height: 16),
                BorderButton(
                    onTapped: () {
                      // Call function
                    },
                    text: 'Cancel'),
                const SizedBox(height: 16),
                FillButton(
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RideProcessingScreen(),
                      ),
                    );
                  },
                  text: 'Pick Up',
                  color: Palette.mainColor30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
