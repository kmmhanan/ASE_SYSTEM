import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/user_model.dart';
import 'package:citytaxi/screens/driverScreens/d_homePage.dart';
import 'package:citytaxi/screens/login_screen.dart';
import 'package:citytaxi/screens/passengerScreens/p_homePage.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.user});

  final User user;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController contactNumController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController idController = TextEditingController();

    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
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
            if (widget.user == User.driver) const SizedBox(height: 16),
            if (widget.user == User.driver)
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
                    builder: (context) => widget.user == User.passenger
                        ? const PHomePage()
                        : const DHomePage(),
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
                        builder: (context) => LoginScreen(user: widget.user),
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
