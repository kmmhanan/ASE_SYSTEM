import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/success_message_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/utils/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            height: 500,
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
                        'Profile',
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
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      Icons.account_circle_sharp,
                      size: 96,
                      color: Palette.black.withOpacity(0.4),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        Text(
                          // firebase_auth.currentFirebaseUser.name,
                          'User Name',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.normal16.copyWith(
                                color: Palette.black,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'email',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.normal16.copyWith(
                                color: Palette.black,
                              ),
                        ),
                      ],
                    )
                  ]),
                ),
                InkWell(
                  onTap: () {
                    // firebase_auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Palette.black,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Sign out',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.normal16.copyWith(
                              color: Palette.black,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FillButton(
                    onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccessMessageScreen(
                            goToScreen: WelcomeScreen(),
                            message: 'Account Deleted Successfully',
                          ),
                        ),
                      );
                    },
                    text: 'Delete Account',
                    color: Palette.red)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
