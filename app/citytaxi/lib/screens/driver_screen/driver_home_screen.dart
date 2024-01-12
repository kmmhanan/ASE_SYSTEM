import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driver_screen/available_hire.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class DHomeScreen extends StatefulWidget {
  const DHomeScreen({super.key});

  @override
  State<DHomeScreen> createState() => _DHomeScreenState();
}

class _DHomeScreenState extends State<DHomeScreen> {
  bool isAvailable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
        toolbarHeight: 56,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Palette.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ),
            );
          },
        ),
        title: Text(
          'Back',
          style: Theme.of(context).textTheme.normal16,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 56,
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 48),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Palette.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'Drive More, Earn More.',
                      style: Theme.of(context).textTheme.bold18,
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/logo/images/map.png',
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Drive Safe... 😊',
                      style: Theme.of(context).textTheme.normal16,
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              if (!isAvailable)
                BorderButton(
                    onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvailableHire(),
                        ),
                      );
                    },
                    text: 'View Hire List'),
              const SizedBox(height: 16),
              FillButton(
                onTapped: () {
                  setState(() {
                    isAvailable = !isAvailable;
                  });
                },
                text: isAvailable ? 'Available' : 'BUSY',
                color: isAvailable ? Palette.green : Palette.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Change Status',
                style: Theme.of(context).textTheme.normal16,
              )
            ],
          ),
        ),
      ),
    );
  }
}