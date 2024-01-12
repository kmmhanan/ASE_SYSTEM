import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/passengerScreens/p_review.dart';
import 'package:flutter/material.dart';

class PPaymentPage extends StatelessWidget {
  const PPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
        //  automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Palette.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      bottomNavigationBar: Container(
        decoration: ShapeDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ))),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: Text('Select Payment',
                    style: Theme.of(context).textTheme.normal16)),
            const SizedBox(height: 50),
            Text(
              'Amount',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.normal16,
            ),
            Text(
              '245.67 Rs',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bold32,
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.10000000149011612),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/logo/images/mastercard.png',
                    height: 40,
                  ),
                  SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Master Card',
                          style: Theme.of(context).textTheme.normal13),
                      SizedBox(height: 8),
                      Text('****    ****    ****   4584',
                          style: Theme.of(context).textTheme.normal13),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PReviewPage()));
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                    color: Palette.green,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child:
                      Text('Pay', style: Theme.of(context).textTheme.normal16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
