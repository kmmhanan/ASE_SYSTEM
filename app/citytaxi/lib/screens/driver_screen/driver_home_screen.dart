import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/home_dropdown.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/aboutus_screen.dart';
import 'package:citytaxi/screens/driver_screen/available_hire.dart';
import 'package:citytaxi/screens/profile_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class DHomeScreen extends StatefulWidget {
  const DHomeScreen({super.key});

  @override
  State<DHomeScreen> createState() => _DHomeScreenState();
}

class _DHomeScreenState extends State<DHomeScreen> {
  bool isDropdownVisible = false;
  bool isAvailable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Palette.mainColor60,
        toolbarHeight: 56,
        elevation: 0,
        title: Text(
          'Passenger Home',
          style: Theme.of(context).textTheme.normal18,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDropdownVisible = !isDropdownVisible;
              });
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
          Positioned(
            top: 0.0, // Adjust the top position as needed
            right: 16.0, // Adjust the right position as needed
            child: Visibility(
              visible: isDropdownVisible,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeDropdown(
                      name: 'Profile',
                      icon: Icons.account_circle_rounded,
                      goTo: ProfileScreen(),
                    ),
                    Container(width: 120, height: 1, color: Palette.black),
                    const HomeDropdown(
                      name: 'About',
                      icon: Icons.lightbulb_circle,
                      goTo: AboutusScreen(),
                    ),
                    Container(width: 120, height: 1, color: Palette.black),
                    const HomeDropdown(
                      name: 'Signout',
                      icon: Icons.exit_to_app_rounded,
                      goTo: WelcomeScreen(),
                    ),

                    // Add more options as needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
