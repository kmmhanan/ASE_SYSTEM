import 'package:citytaxi/components/baground_container.dart';
import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/driver_screen/ride_payment.dart';
import 'package:citytaxi/components/detailed_card.dart';
import 'package:flutter/material.dart';

class RideProcessingScreen extends StatelessWidget {
  const RideProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.pop(context);
      },
      widget: BagroundContainer(
        heading: 'Ride Processing',
        bodyWidgets: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    // Need to change the image
                    'assets/logo/images/ride2.png',
                  ),
                ),
                const SizedBox(height: 16),
                const DetailedCard(),
                const SizedBox(height: 16),
                FillButton(
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RidePaymentScreen(),
                      ),
                    );
                  },
                  text: 'Finish Ride',
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
