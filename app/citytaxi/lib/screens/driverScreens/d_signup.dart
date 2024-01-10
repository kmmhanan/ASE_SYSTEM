import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/driverScreens/d_welcomeScreen.dart';
import 'package:citytaxi/screens/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../passengerScreens/p_login_screen.dart';

class DSignUpPage extends StatefulWidget {
  const DSignUpPage({super.key});

  @override
  State<DSignUpPage> createState() => _DSignUpPageState();
}

class _DSignUpPageState extends State<DSignUpPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController contactNumController = TextEditingController();
    final TextEditingController idController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A2A46),
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Palette.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DWelcomeScreen(),
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
              'Create An Account',
              style: TextStyle(
                  color: Palette.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 25),
            CustomTextField(label: 'Name', controller: nameController),
            const SizedBox(height: 8),
            CustomTextField(
                label: 'Contact Number', controller: contactNumController),
            const SizedBox(height: 8),
            CustomTextField(
                label: 'National ID Card', controller: idController),
            const SizedBox(height: 8),
            CustomTextField(
                label: 'Email Address', controller: emailController),
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const JobsDetails(),
                //     ));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Palette.white,
                fixedSize: const Size(343, 56),
                elevation: 0,
              ),
              child: Text(
                'SIGN UP',
                style: TextStyle(
                    color: Palette.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ALREADY HAVE AN ACCOUNT?   ',
                    style: TextStyle(
                        color: Palette.white,
                        fontSize: 13.30,
                        fontWeight: FontWeight.w400)),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PLoginScreen(),
                        ));
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Palette.mainColor30,
                        fontSize: 13.30,
                        fontWeight: FontWeight.w400),
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
