import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/passengerScreens/p_HomePage/p_confirmationPage.dart';
import 'package:citytaxi/screens/passengerScreens/p_HomePage/p_homePage.dart';
import 'package:citytaxi/screens/passengerScreens/p_HomePage/p_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PPaymentPage extends StatelessWidget {
  const PPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Palette.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PHomePage(),
                  ));
            }),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      body: Container(
          //  margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Palette.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
          ),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select Payment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // Text(
            //   'Amount',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: Palette.black, fontSize: 16, fontWeight: FontWeight.w400),
            // )
          ])),
      bottomNavigationBar: Container(
        color: Palette.white,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PReviewPage(),
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: ShapeDecoration(
                    color: Palette.mainColor30,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Pay',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
