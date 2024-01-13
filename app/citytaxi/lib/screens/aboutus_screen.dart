import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class AboutusScreen extends StatelessWidget {
  const AboutusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          left: 16,
          top: MediaQuery.of(context).padding.top + 24,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 48,
        ),
        child: Center(
          child: Container(
            width: double.infinity,
            height: 600,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 32,
                      width: double.infinity,
                      child: Text(
                        'About City Taxi (PVT) Ltd',
                        style: Theme.of(context).textTheme.bold18.copyWith(
                              color: Palette.black,
                            ),
                      ),
                    ),
                    Positioned(
                      right: -8,
                      top: -8,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          size: 32,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      'Welcome to City Taxi!\n\nYour trusted ride-hailing service in Island-wide city areas. We prioritize your needs for efficient, prompt, and safe journeys, providing a seamless and comfortable travel experience.\n\nOur Commitment:\n\nPerformance: \nWe are committed to getting you to your destination promptly, efficiently, comfortably, and, above all, safely.\n\nSuperior Service:\nEnjoy timely pick-ups, private usage, and dedicated customer care that goes the extra mile to ensure your satisfaction.\n\nQuality:\nOur fleet of clean, well-maintained vehicles and courteous drivers reflect our commitment to delivering a high standard of service.\n\nHappy Travels!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .normal16
                          .copyWith(color: Palette.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
