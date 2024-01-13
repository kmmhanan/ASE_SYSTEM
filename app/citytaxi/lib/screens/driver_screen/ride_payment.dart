import 'package:citytaxi/components/baground_container.dart';
import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/components/payment_card.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driver_screen/driver_home_screen.dart';
import 'package:citytaxi/screens/success_message_screen.dart';
import 'package:flutter/material.dart';

class RidePaymentScreen extends StatelessWidget {
  const RidePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.pop(context);
      },
      widget: BagroundContainer(
        heading: 'Payment Confermation',
        bodyWidgets: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    // Need to change the image
                    'assets/logo/images/payment.png',
                  ),
                ),
                const SizedBox(height: 16),
                Text('Amount', style: Theme.of(context).textTheme.normal16),
                const SizedBox(height: 8),
                Text('245.67 Rs', style: Theme.of(context).textTheme.bold32),
                const SizedBox(height: 32),
                const PaymentCard(),
                const SizedBox(height: 16),
                FillButton(
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessMessageScreen(
                          goToScreen: DHomeScreen(),
                          message: 'Ride Completed.\nThank You.',
                        ),
                      ),
                    );
                  },
                  text: 'Payment Recieved',
                  color: Palette.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
