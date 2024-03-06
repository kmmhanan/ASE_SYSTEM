import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/components/review_feild.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/passenger_screen/passenger_home_screen.dart';
import 'package:citytaxi/screens/passenger_screen/passenger_payment_screen.dart';
import 'package:citytaxi/screens/success_message_screen.dart';
import 'package:flutter/material.dart';

class PReviewScreen extends StatefulWidget {
  const PReviewScreen({super.key});

  @override
  State<PReviewScreen> createState() => _PReviewScreenState();
}

class _PReviewScreenState extends State<PReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PPaymentScreen(),
          ),
        );
      },
      widget: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 56),
                    padding: const EdgeInsets.fromLTRB(16, 72, 16, 32),
                    decoration: BoxDecoration(
                      color: Palette.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Driver Name',
                          style: Theme.of(context).textTheme.bold16,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'LP-2343',
                          style: Theme.of(context).textTheme.bold13,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'How is your trip?',
                          style: Theme.of(context).textTheme.normal16,
                        ),
                        const SizedBox(height: 32),
                        const ReviewFeild(rating: 2, label: 'Driver'),
                        const SizedBox(height: 16),
                        const ReviewFeild(rating: 4, label: 'Safety'),
                        const SizedBox(height: 16),
                        const ReviewFeild(rating: 3, label: 'Clean'),
                        const SizedBox(height: 32),
                        Container(
                          height: 92,
                          // width: MediaQuery.of(context).size.width - 58,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Palette.white.withOpacity(0.1),
                          ),
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bold16,
                            decoration: InputDecoration(
                              hintText: 'Note',
                              hintStyle: Theme.of(context).textTheme.normal16,
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        BorderButton(
                          onTapped: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SuccessMessageScreen(
                                  goToScreen: PHomeScreen(),
                                  message: 'Drive Completed Successfully.',
                                ),
                              ),
                            );
                          },
                          text: 'Cancel',
                        ),
                        const SizedBox(height: 16),
                        FillButton(
                          onTapped: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SuccessMessageScreen(
                                  goToScreen: PHomeScreen(),
                                  message:
                                      'Thank you for feedback\nDrive Completed Successfully.',
                                ),
                              ),
                            );
                          },
                          text: 'Submit',
                          color: Palette.yellow,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      child: Container(
                    width: 112,
                    height: 112,
                    decoration: BoxDecoration(
                      color: Palette.mainColor10,
                      borderRadius: BorderRadius.circular(56),
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
