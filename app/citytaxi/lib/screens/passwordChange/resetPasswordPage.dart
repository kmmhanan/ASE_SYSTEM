import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/passengerScreens/p_login_screen.dart';
import 'package:citytaxi/screens/passwordChange/passwordChangedPage.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Palette.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PLoginScreen(),
                  ));
            }),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Text(
              'Reset Password',
              style: TextStyle(
                  color: Palette.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Text(
              'Ser your new password',
              style: TextStyle(
                color: Palette.white,
                fontSize: 13.30,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 25),
            CustomTextField(
                label: 'Email Address', controller: emailController),
            const SizedBox(height: 25),
            CustomTextField(label: 'Password', controller: passwordController),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordChanged(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Palette.white,
                fixedSize: const Size(343, 56),
                elevation: 0,
              ),
              child: Text(
                'Confirm',
                style: TextStyle(
                    color: Palette.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
