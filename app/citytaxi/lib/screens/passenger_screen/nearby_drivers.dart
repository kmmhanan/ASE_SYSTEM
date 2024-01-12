import 'package:citytaxi/components/baground_container.dart';
import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/components/drivers_card.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/passenger_screen/passenger_home_screen.dart';
import 'package:citytaxi/screens/passenger_screen/passenger_payment_screen.dart';
import 'package:citytaxi/screens/success_message_screen.dart';
import 'package:flutter/material.dart';

class PNearDrivers extends StatelessWidget {
  const PNearDrivers({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PHomeScreen(),
          ),
        );
      },
      widget: BagroundContainer(
        heading: 'Driver nearby you',
        bodyWidgets: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const DriverCard();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                BorderButton(
                    onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PHomeScreen(),
                        ),
                      );
                    },
                    text: 'Cancel'),
                const SizedBox(height: 16),
                FillButton(
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessMessageScreen(
                          goToScreen: PPaymentScreen(),
                          message: 'Thank You For Your Confirmation!',
                        ),
                      ),
                    );
                  },
                  text: 'Confirm',
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
