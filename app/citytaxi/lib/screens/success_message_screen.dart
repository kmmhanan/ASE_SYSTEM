import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class SuccessMessageScreen extends StatefulWidget {
  const SuccessMessageScreen({
    super.key,
    required this.goToScreen,
    required this.message,
  });

  final Widget goToScreen;
  final String message;

  @override
  State<SuccessMessageScreen> createState() => _SuccessMessageScreenState();
}

class _SuccessMessageScreenState extends State<SuccessMessageScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(
      const Duration(milliseconds: 3500),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget.goToScreen,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/logo/icons/tick.png', height: 100),
          const SizedBox(height: 24),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.normal16,
          ),
        ],
      ),
    );
  }
}
