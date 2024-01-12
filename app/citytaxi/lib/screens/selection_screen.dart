import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/user_model.dart';
import 'package:citytaxi/screens/login_screen.dart';
import 'package:citytaxi/screens/signup_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key, required this.user});

  final User user;

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
              user == User.driver
                  ? 'Have a good day, Drive Safe'
                  : 'Have a better sharing experience',
              style: Theme.of(context).textTheme.normal16,
            ),
            const SizedBox(height: 50),
            CTWhiteButton(
              onTapped: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(user: user),
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
                      builder: (context) => LoginScreen(user: user),
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
