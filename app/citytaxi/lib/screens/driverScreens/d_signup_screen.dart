import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driverScreens/d_login_screen.dart';
import 'package:citytaxi/screens/driverScreens/d_welcome_screen.dart';
import 'package:citytaxi/screens/passengerScreens/p_login_screen.dart';
import 'package:citytaxi/screens/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'driver_homePage/d_homePage.dart';

class DSignUpScreen extends StatefulWidget {
  const DSignUpScreen({super.key});

  @override
  State<DSignUpScreen> createState() => _DSignUpScreenState();
}

class _DSignUpScreenState extends State<DSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController contactNumController = TextEditingController();
    final TextEditingController idController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

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
              'Create An Account',
              style: Theme.of(context).textTheme.bold24,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Name',
              controller: nameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Contact Number',
              controller: contactNumController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'National ID Card',
              controller: idController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Email Address',
              controller: emailController,
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
              text: 'SIGN UP',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ALREADY HAVE AN ACCOUNT?   ',
                    style: Theme.of(context).textTheme.normal13),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DLoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'LOGIN',
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
