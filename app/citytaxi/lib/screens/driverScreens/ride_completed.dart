import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driverScreens/d_homePage.dart';
import 'package:flutter/material.dart';

class RideCompleted extends StatefulWidget {
  const RideCompleted({super.key});

  @override
  State<RideCompleted> createState() => _RideCompletedState();
}

class _RideCompletedState extends State<RideCompleted> {
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 3500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const DHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/icons/tick.png', height: 100, width: 100),
            const SizedBox(height: 25),
            Text(
              'Ride Completed.\nThank You.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.normal16,
            ),
          ],
        ),
      ),
    );
  }
}
