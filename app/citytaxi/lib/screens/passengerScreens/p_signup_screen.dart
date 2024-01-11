import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/passengerScreens/p_HomePage/p_homePage.dart';
import 'package:citytaxi/screens/passengerScreens/p_login_screen.dart';
import 'package:citytaxi/screens/passengerScreens/p_welcome_screen.dart';
import 'package:citytaxi/screens/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PSignUpScreen extends StatefulWidget {
  const PSignUpScreen({super.key});

  @override
  State<PSignUpScreen> createState() => _PSignUpScreenState();
}

class _PSignUpScreenState extends State<PSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController contactNumController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PWelcomeScreen(),
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
              label: 'Email Address',
              controller: emailController,
            ),
            const Expanded(child: SizedBox()),
            CTWhiteButton(
              onTapped: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PHomePage(),
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
                        builder: (context) => const PLoginScreen(),
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
