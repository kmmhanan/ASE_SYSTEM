import 'package:citytaxi/constants/palette.dart';
import 'package:flutter/material.dart';

class RideProcessingScreen extends StatelessWidget {
  const RideProcessingScreen({super.key});

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
              // Navigator.push(context, MaterialPageRoute(builder: (context) => DWelcomeScreen()));
            }),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      body: Column(
        children: [Image.asset("app/citytaxi/assets/logo/images/ride2.png")],
      ),
    );
  }
}
