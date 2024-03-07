import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/components/progress_dialog.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driver_screen/driver_home_screen.dart';
import 'package:citytaxi/screens/passenger_screen/passenger_home_screen.dart';
import 'package:citytaxi/screens/password_screen/forgot_password_screen.dart';
import 'package:citytaxi/screens/signup_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/components/custom_text_field.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:citytaxi/utils/methods/common_methods.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:citytaxi/models/user_model.dart' as my_user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.user});

  final my_user.User user;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();
  CommonMethods commonMethods = CommonMethods();

  checkIfNetworkIsAvailable() {
    commonMethods.checkConnectivity(context);

    logInvalidateForm();
  }

  logInvalidateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Please Enter Correct Email Address");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Please Enter Your Correct Password");
    } else {
      logInUser();
    }
  }

  logInUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return ProgressDialog(
          message: 'Processing, Please wait..',
        );
      }),
    );

// checking driver login
    if (widget.user == my_user.User.driver) {
      final firebase_auth.User? firebaseUser = (await firebase_auth.FirebaseAuth.instance
              .signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      )
              .catchError((errorMsg) {
        // Navigator.pop(context);
        // Fluttertoast.showToast(msg: 'Error: $errorMsg');
        Fluttertoast.showToast(msg: 'Login Failed! Please check your credential.');
      }))
          .user;

      if (context.mounted) {
        await Fluttertoast.showToast(msg: 'Login Successful');
        // Navigator.pop(context);
      } else {
        return;
      }
      // Navigator.pop(context);
      // Fluttertoast.showToast(msg: 'Account logging In');

      if (firebaseUser != null) {
        DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("drivers").child(firebaseUser.uid);

        driverRef.once().then((snap) {
          if (snap.snapshot.value != null) {
            if ((snap.snapshot.value as Map)["blockStatus"] == "no") {
              userName = (snap.snapshot.value as Map)["name"];
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const DHomeScreen())));
            } else {
              FirebaseAuth.instance.signOut();
              Fluttertoast.showToast(msg: 'You are blocked. Contact Admin: admin.citytaxi@.com');
            }
          } else {
            FirebaseAuth.instance.signOut();
            Fluttertoast.showToast(msg: 'Your record do not exist as a Driver');
          }
        });
      }
    }

// checking passenger login
    if (widget.user == my_user.User.passenger) {
      final firebase_auth.User? firebaseUser = (await firebase_auth.FirebaseAuth.instance
              .signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      )
              .catchError((errorMsg) {
        // Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Login Failed! Please check your credential.');
      }))
          .user;

      if (context.mounted) {
        await Fluttertoast.showToast(msg: 'Login Successful');
        // Navigator.pop(context);
      } else {
        return;
      }

      //
      if (firebaseUser != null) {
        DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("passengers").child(firebaseUser.uid);

        usersRef.once().then((snap) {
          if (snap.snapshot.value != null) {
            if ((snap.snapshot.value as Map)["blockStatus"] == "no") {
              userName = (snap.snapshot.value as Map)["name"];
              userEmail = (snap.snapshot.value as Map)["email"];
              userPhone = (snap.snapshot.value as Map)["contactNum"];
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const PHomeScreen())));
            } else {
              FirebaseAuth.instance.signOut();
              Fluttertoast.showToast(msg: 'You are blocked. Contact Admin: admin.citytaxi@gmail.com');
            }
          } else {
            FirebaseAuth.instance.signOut();
            Fluttertoast.showToast(msg: 'Your record do not exist as a User');
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: emailTextEditingController,
                keyBoardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                controller: passwordTextEditingController,
              ),
              const SizedBox(height: 24),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(user: widget.user),
                      ),
                    );
                  },
                  child: Text('Forgot Password ?', style: Theme.of(context).textTheme.bold13),
                ),
              ),
              const Expanded(child: SizedBox()),
              FillButton(
                onTapped: () {
                  checkIfNetworkIsAvailable();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => widget.user == User.passenger ? const PHomeScreen() : const DHomeScreen(),
                  //   ),
                  // );
                },
                text: 'LOGIN',
                color: Palette.white,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('DON’T HAVE AN ACCOUNT?   ', style: Theme.of(context).textTheme.normal13),
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
