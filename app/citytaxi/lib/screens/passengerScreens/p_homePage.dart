import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/passengerScreens/p_nearDrinvers.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PHomePage extends StatelessWidget {
  const PHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );
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
                      builder: (context) => WelcomeScreen(),
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
              color: Palette.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  style: TextStyle(color: Palette.white),
                  decoration: InputDecoration(
                    labelText: 'PICKUP',
                    labelStyle: TextStyle(color: Palette.white),
                  ),
                  cursorColor: Palette.white,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                ),
                SizedBox(height: 25),
                TextFormField(
                  style: TextStyle(color: Palette.white),
                  decoration: InputDecoration(
                    labelText: 'DROP-OFF',
                    labelStyle: TextStyle(color: Palette.white),
                  ),
                  cursorColor: Palette.white,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                ),
                SizedBox(height: 60),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PNearDrivers(),
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
                    child: Text('Search',
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
