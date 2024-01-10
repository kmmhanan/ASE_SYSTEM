import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/driverScreens/d_signup.dart';
import 'package:citytaxi/screens/passengerScreens/p_login_screen.dart';
import 'package:citytaxi/screens/passengerScreens/p_signup_screen.dart';
import 'package:citytaxi/welcome_screen.dart';
import 'package:flutter/material.dart';

class DWelcomeScreen extends StatelessWidget {
  const DWelcomeScreen({super.key});

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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ));
          },
        ),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/logo/welcome.png', height: 450, width: 450),
            const SizedBox(height: 40),
            Text(
              'Welcome',
              style: TextStyle(
                  color: Palette.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Text(
              'Have a better riding experience',
              style: TextStyle(
                  color: Palette.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DSignUpPage(),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: ShapeDecoration(
                  color: Palette.mainColor30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Create an account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            const SizedBox(height: 18),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PLoginScreen(),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Palette.mainColor30),
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        color: Palette.mainColor30,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
