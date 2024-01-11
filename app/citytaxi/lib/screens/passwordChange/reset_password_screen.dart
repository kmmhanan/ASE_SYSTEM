import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/passengerScreens/p_login_screen.dart';
import 'package:citytaxi/screens/passwordChange/password_changed.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
            builder: (context) => const PLoginScreen(),
          ),
        );
      },
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text('Reset Password', style: Theme.of(context).textTheme.bold24),
            const SizedBox(height: 16),
            Text('Set new password',
                style: Theme.of(context).textTheme.normal13),
            const SizedBox(height: 24),
            CustomTextField(
                label: 'Email Address', controller: emailController),
            const SizedBox(height: 16),
            CustomTextField(label: 'Password', controller: passwordController),
            const SizedBox(height: 16),
            CustomTextField(
                label: 'Confirm Password', controller: passwordController),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: CTWhiteButton(
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PasswordChanged(),
                      ),
                    );
                  },
                  text: 'Confirm',
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}