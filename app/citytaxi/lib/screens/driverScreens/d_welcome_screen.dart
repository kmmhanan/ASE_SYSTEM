import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driverScreens/d_signup_screen.dart';
import 'package:citytaxi/screens/passengerScreens/p_login_screen.dart';
import 'package:citytaxi/welcome_screen.dart';
import 'package:flutter/material.dart';

class DWelcomeScreen extends StatelessWidget {
  const DWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBarTitle: 'back',
      appBarOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
        );
      },
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/logo/welcome.png',
                width: 450,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.bold24,
            ),
            const SizedBox(height: 16),
            Text(
              'Have a good day, Drive Safe',
              style: Theme.of(context).textTheme.normal16,
            ),
            const SizedBox(height: 50),
            CTWhiteButton(
              onTapped: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DSignUpScreen(),
                  ),
                );
              },
              text: 'Create Account',
            ),
            const SizedBox(height: 24),
            BorderButton(
                onTapped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PLoginScreen(),
                    ),
                  );
                },
                text: 'Login'),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
