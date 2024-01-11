import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driverScreens/d_signup_screen.dart';
import 'package:citytaxi/screens/driverScreens/d_welcome_screen.dart';
import 'package:citytaxi/screens/driverScreens/driver_homePage/d_homePage.dart';
import 'package:citytaxi/screens/passengerScreens/p_HomePage/p_homePage.dart';
import 'package:citytaxi/screens/passwordChange/forgot_password_screen.dart';
import 'package:citytaxi/screens/passengerScreens/p_signup_screen.dart';
import 'package:citytaxi/screens/passengerScreens/p_welcome_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';

class DLoginScreen extends StatefulWidget {
  const DLoginScreen({super.key});

  @override
  State<DLoginScreen> createState() => _DLoginScreenState();
}

class _DLoginScreenState extends State<DLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DWelcomeScreen(),
          ),
        );
      },
      widget: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              'Login',
              style: Theme.of(context).textTheme.bold24,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Email Address',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Password',
              controller: passwordController,
            ),
            const SizedBox(height: 24),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text('Forgot Password ?',
                    style: Theme.of(context).textTheme.bold13),
              ),
            ),
            const Expanded(child: SizedBox()),
            CTWhiteButton(
              onTapped: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DHomePage(),
                  ),
                );
              },
              text: 'LOGIN',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('DON’T HAVE AN ACCOUNT?   ',
                    style: Theme.of(context).textTheme.normal13),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DSignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'SIGN UP',
                    style: Theme.of(context).textTheme.bold13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
