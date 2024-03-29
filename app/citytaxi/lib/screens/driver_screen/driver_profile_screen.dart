import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/success_message_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/utils/authentication/firebase_auth_services.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController carTextEditingController = TextEditingController();

  setDriverInfo() {
    setState(() {
      nameTextEditingController.text = driverName;
      phoneTextEditingController.text = driverPhone;
      emailTextEditingController.text = FirebaseAuth.instance.currentUser!.email.toString();
      carTextEditingController.text = "$carNumber - $carModel - $carType";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDriverInfo();
  }

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
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 700,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  // title nd close
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // image
                        Image.asset(
                          "assets/logo/images/profile.png",
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 25),

                        // driver name
                        TextField(
                          controller: nameTextEditingController,
                          textAlign: TextAlign.center,
                          enabled: false,
                          style: TextStyle(fontSize: 16, color: Palette.mainColor60),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
                            prefix: Icon(Icons.person, color: Palette.mainColor60),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // driver phone
                        TextField(
                          controller: phoneTextEditingController,
                          textAlign: TextAlign.center,
                          enabled: false,
                          style: TextStyle(fontSize: 16, color: Palette.mainColor60),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
                            prefix: Icon(Icons.phone_android_rounded, color: Palette.mainColor60),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // driver email
                        TextField(
                          controller: emailTextEditingController,
                          textAlign: TextAlign.center,
                          enabled: false,
                          style: TextStyle(fontSize: 16, color: Palette.mainColor60),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
                            prefix: Icon(Icons.email, color: Palette.mainColor60),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // driver name
                        TextField(
                          controller: carTextEditingController,
                          textAlign: TextAlign.center,
                          enabled: false,
                          style: TextStyle(fontSize: 16, color: Palette.mainColor60),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
                            prefix: Icon(Icons.drive_eta_rounded, color: Palette.mainColor60),
                          ),
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Fluttertoast.showToast(msg: 'Signed out successfully');
                      Navigator.pushReplacement(
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
                        color: Palette.red,
                        shape: RoundedRectangleBorder(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
