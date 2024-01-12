import 'package:citytaxi/constants/palette.dart';
// import 'package:citytaxi/screens/passenger_screen/review_screen.dart';
import 'package:citytaxi/screens/splash_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
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
      home: const SplashScreen(),
      // Current Working Screen
      // home: const PReviewScreen(),
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
