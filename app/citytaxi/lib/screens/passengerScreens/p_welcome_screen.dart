import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/passengerScreens/p_login_screen.dart';
import 'package:citytaxi/screens/passengerScreens/p_signup_screen.dart';
import 'package:flutter/material.dart';

class PWelcomeScreen extends StatelessWidget {
  const PWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Palette.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/logo/welcome.png',
                // height: 450,
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
              'Have a better sharing experience',
              style: Theme.of(context).textTheme.normal16,
            ),
            const SizedBox(height: 50),
            CTWhiteButton(
              onTapped: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PSignUpScreen(),
                  ),
                );
              },
              text: 'Create Account',
            ),
            const SizedBox(height: 18),
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
