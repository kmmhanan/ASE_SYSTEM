import 'package:citytaxi/components/baground_container.dart';
import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/components/listcard_widget.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/driver_screen/driver_home_screen.dart';
import 'package:citytaxi/screens/driver_screen/ride_details.dart';
import 'package:flutter/material.dart';

class AvailableHire extends StatelessWidget {
  const AvailableHire({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DHomeScreen(),
          ),
        );
      },
      widget: BagroundContainer(
        heading: 'Hire List',
        bodyWidgets: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const HireCard(
                        fromAddress: '23/2, Athapttu Mawatha, Dehiwala ',
                        toAddress: '32, Dr. Pons Rd, Bambalpitiya ',
                        distance: '45km',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                BorderButton(
                    onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DHomeScreen(),
                        ),
                      );
                    },
                    text: 'Cancel'),
                const SizedBox(height: 16),
                FillButton(
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RideDetailsScreen(),
                      ),
                    );
                  },
                  text: 'Pick Up',
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
