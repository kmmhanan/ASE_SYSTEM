import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/screens/driverScreens/d_signup_screen.dart';
import 'package:citytaxi/screens/passwordChange/password_changed.dart';
import 'package:citytaxi/screens/passwordChange/reset_password_screen.dart';
import 'package:citytaxi/splash_screen.dart';
import 'package:citytaxi/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CityTaxi',
      theme: ThemeData(
        primaryColor: Palette.mainColor60,
        fontFamily: 'Merriweather Sans',
      ),
      // home: const SplashScreen(),
      // Current Working Screen
      home: const DSignUpScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeScreen(),
    );
  }
}
