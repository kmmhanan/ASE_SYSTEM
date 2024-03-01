import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/success_message_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/utils/firebase_auth_services.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // text name and email
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.normal16.copyWith(
                                    color: Palette.darkgrey,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Email: ',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.normal16.copyWith(
                                    color: Palette.darkgrey,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        // user's name and email
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.normal16.copyWith(
                                    color: Palette.mainColor60,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              userEmail,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.normal16.copyWith(
                                    color: Palette.mainColor60,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ]),
                ),
                InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Fluttertoast.showToast(msg: 'Signed out successfully');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
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
