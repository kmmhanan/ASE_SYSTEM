import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/user_model.dart';
import 'package:citytaxi/screens/login_screen.dart';
import 'package:citytaxi/screens/password_screen/link_forgot_password.dart';
import 'package:flutter/material.dart';
import '../../components/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(user: user),
          ),
        );
      },
      widget: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text('Forgot Password',
                  style: Theme.of(context).textTheme.bold24),
              const SizedBox(height: 16),
              Text(
                  'Submit your email address & we will send you link to reset your password',
                  style: Theme.of(context).textTheme.normal13),
              const SizedBox(height: 24),
              CustomTextField(
                  label: 'Email Address', controller: emailController),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: FillButton(
                    onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LinkForgotPassword(user: user),
                        ),
                      );
                    },
                    text: 'Reset Password',
                    color: Palette.white,
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
