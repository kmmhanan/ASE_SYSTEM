import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/user_model.dart';
import 'package:citytaxi/screens/password_screen/reset_password_screen.dart';
import 'package:flutter/material.dart';

class LinkForgotPassword extends StatefulWidget {
  const LinkForgotPassword({super.key, required this.user});

  final User user;

  @override
  State<LinkForgotPassword> createState() => _LinkForgotPasswordState();
}

class _LinkForgotPasswordState extends State<LinkForgotPassword> {
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
            builder: (context) => ResetPasswordScreen(user: widget.user),
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
          Image.asset('assets/logo/icons/mail.png', height: 40),
          const SizedBox(height: 16),
          Text(
            'We’ve sent you an email with a link',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.normal16,
          ),
        ],
      ),
    );
  }
}
