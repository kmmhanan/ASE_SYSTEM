import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/user_model.dart';
import 'package:citytaxi/screens/driver_screen/driver_home_screen.dart';
import 'package:citytaxi/screens/passenger_screen/passenger_home_screen.dart';
import 'package:citytaxi/screens/password_screen/forgot_password_screen.dart';
import 'package:citytaxi/screens/signup_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.user});

  final User user;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return DefaultScreen(
      appBarTitle: 'Back',
      appBarOnPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
        );
      },
      widget: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 56,
          padding: EdgeInsets.only(
            left: 16,
            top: MediaQuery.of(context).padding.top,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Login',
                style: Theme.of(context).textTheme.bold24,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Email Address',
                controller: emailController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                controller: passwordController,
              ),
              const SizedBox(height: 24),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ForgotPasswordScreen(user: widget.user),
                      ),
                    );
                  },
                  child: Text('Forgot Password ?',
                      style: Theme.of(context).textTheme.bold13),
                ),
              ),
              const Expanded(child: SizedBox()),
              FillButton(
                onTapped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.user == User.passenger
                          ? const PHomeScreen()
                          : const DHomeScreen(),
                    ),
                  );
                },
                text: 'LOGIN',
                color: Palette.white,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('DON’T HAVE AN ACCOUNT?   ',
                      style: Theme.of(context).textTheme.normal13),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(user: widget.user),
                        ),
                      );
                    },
                    child: Text(
                      'SIGN UP',
                      style: Theme.of(context).textTheme.bold13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
