import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/user_model.dart';
import 'package:citytaxi/screens/selection_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Palette.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/logo/carlogo.png', height: 100, width: 100),
              Text(
                'CITY TAXI',
                style: Theme.of(context).textTheme.bold18,
              ),
              const SizedBox(height: 64),
              Text(
                'Select User',
                style: Theme.of(context).textTheme.bold16,
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => const PWelcomeScreen(),
                      builder: (context) => const SelectionScreen(
                        user: User.passenger,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: ShapeDecoration(
                    gradient: Palette.topBarGradient,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Passenger',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.normal16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => const DWelcomeScreen(),
                      builder: (context) => const SelectionScreen(
                        user: User.driver,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: ShapeDecoration(
                    color: Palette.mainColor30,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Driver',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.normal16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
