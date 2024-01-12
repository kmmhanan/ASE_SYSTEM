import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/passenger_screen/passenger_home_screen.dart';
import 'package:citytaxi/screens/passenger_screen/passenger_payment_screen.dart';
import 'package:citytaxi/screens/password_screen/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PRideCompletePage extends StatefulWidget {
  const PRideCompletePage({super.key});

  @override
  State<PRideCompletePage> createState() => _PRideCompletePageState();
}

class _PRideCompletePageState extends State<PRideCompletePage> {
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 3500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const PHomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Palette.mainColor60,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/icons/tick.png', height: 100, width: 100),
            SizedBox(height: 25),
            Text(
              'Ride Completed.\nThank You.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Palette.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
