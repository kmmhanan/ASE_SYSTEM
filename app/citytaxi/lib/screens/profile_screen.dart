import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
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
                      Expanded(
                        child: Container(
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
                  SizedBox(
                    height: 350,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle_sharp,
                            size: 96,
                            color: Palette.black.withOpacity(0.4),
                          ),
                          const SizedBox(height: 32),
                          Column(
                            children: [
                              Text(
                                'User Name',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .normal16
                                    .copyWith(
                                      color: Palette.black,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'usertest@gmail.com',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .normal16
                                    .copyWith(
                                      color: Palette.black,
                                    ),
                              ),
                            ],
                          )
                        ]),
                  ),
                  InkWell(
                    onTap: () {},
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
                      onTapped: () {},
                      text: 'Delete Account',
                      color: Palette.red)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
