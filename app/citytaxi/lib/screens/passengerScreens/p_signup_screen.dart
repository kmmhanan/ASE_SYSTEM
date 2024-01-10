import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
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
                builder: (context) => const PWelcomeScreen(),
              ),
            );
          },
        ),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Text(
              'Create An Account',
              style: Theme.of(context).textTheme.normal24,
            ),
            const SizedBox(height: 25),
            CustomTextField(
              label: 'Name',
              controller: nameController,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Contact Number',
              controller: contactNumController,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Email Address',
              controller: emailController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 14),
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
