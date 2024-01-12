import 'package:citytaxi/components/baground_container.dart';
import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/passenger_screen/review_screen.dart';
import 'package:flutter/material.dart';

class PPaymentScreen extends StatelessWidget {
  const PPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.pop(context);
      },
      widget: Column(
        children: [
          const SizedBox(height: 300),
          Expanded(
            child: BagroundContainer(
              heading: 'Select Payment',
              bodyWidgets: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Amount',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.normal16,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '245.67 Rs',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bold32,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: ShapeDecoration(
                    color: Palette.black.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Palette.white,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/logo/images/mastercard.png',
                        height: 40,
                      ),
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Master Card',
                              style: Theme.of(context).textTheme.normal13),
                          const SizedBox(height: 8),
                          Text('****    ****    ****   4584',
                              style: Theme.of(context).textTheme.normal13),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                FillButton(
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PReviewScreen(),
                      ),
                    );
                  },
                  text: 'Pay',
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
