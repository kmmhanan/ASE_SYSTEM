import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/passengerScreens/p_paymentPage.dart';
import 'package:citytaxi/screens/passengerScreens/p_rideCompletePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PReviewPage extends StatelessWidget {
  const PReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.mainColor60,
        //
        appBar: AppBar(
          backgroundColor: Palette.mainColor60,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Palette.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PPaymentPage(),
                    ));
              }),
          title: Text('Back', style: TextStyle(color: Palette.white)),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PRideCompletePage(),
                        ));
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
                    child: Text('Submit Review',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Palette.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
