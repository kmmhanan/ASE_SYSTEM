import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/passenger_screen/nearby_drivers.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class PHomeScreen extends StatelessWidget {
  const PHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Search Vehicle',
                style: Theme.of(context).textTheme.bold16,
              ),
              const SizedBox(height: 4),
              Text(
                'START A RIDE',
                style: Theme.of(context).textTheme.bold24,
              )
            ],
          ),
          const SizedBox(height: 56),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Palette.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Palette.white),
                  decoration: InputDecoration(
                    labelText: 'PICKUP',
                    labelStyle: TextStyle(color: Palette.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.white),
                    ),
                  ),
                  cursorColor: Palette.white,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  style: TextStyle(color: Palette.white),
                  decoration: InputDecoration(
                    labelText: 'DROP-OFF',
                    labelStyle: TextStyle(color: Palette.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.white),
                    ),
                  ),
                  cursorColor: Palette.white,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                ),
                const SizedBox(height: 64),
                FillButton(
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PNearDrivers(),
                      ),
                    );
                  },
                  text: 'Search',
                  color: Palette.mainColor30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
