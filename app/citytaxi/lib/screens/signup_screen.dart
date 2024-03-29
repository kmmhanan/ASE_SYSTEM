import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driver_screen/car_info_screen.dart';
import 'package:citytaxi/utils/authentication/firebase_auth_services.dart';
import 'package:citytaxi/utils/methods/common_methods.dart';
import 'package:citytaxi/components/progress_dialog.dart';
import 'package:citytaxi/screens/login_screen.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:citytaxi/components/custom_text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:citytaxi/models/user_model.dart' as my_user;
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.user}) : super(key: key);

  final my_user.User user;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController contactNumTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController nicTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();
  CommonMethods commonMethods = CommonMethods();

  checkIfNetworkIsAvailable() {
    commonMethods.checkConnectivity(context);

    signupvalidateForm();
  }

  signupvalidateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "Name must be at least 3 Characters");
    } else if (contactNumTextEditingController.text.isEmpty || contactNumTextEditingController.text.length < 10) {
      Fluttertoast.showToast(msg: "Phone Number is required and should be 10 characters long");
    } else if (widget.user == my_user.User.driver && !nicTextEditingController.text.contains(RegExp(r'^\d{9}[VX]|d{9}[vx]|\d{12}$'))) {
      Fluttertoast.showToast(msg: "NIC is not Valid");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not Valid");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be at least 6 Characters");
    } else {
      saveDriverInforNow();
    }
  }

  saveDriverInforNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return ProgressDialog(
          message: 'Processing, Please wait..',
        );
      }),
    );

    // driver database
    if (widget.user == my_user.User.driver) {
      final firebase_auth.User? firebaseDriver = (await firebase_auth.FirebaseAuth.instance
              .createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      )
              .catchError((msg) {
        Navigator.pop(context);
      }))
          .user;

      if (context.mounted) {
        await Fluttertoast.showToast(msg: 'Account has been created Sucessfully, Please Enter Your Car Details');
        // await Fluttertoast.showToast(msg: 'Account has been created');
        // await Navigator.push(context, MaterialPageRoute(builder: ((context) => CarInfoScreen())));

        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Account Creation Failed! Try Again Later');

        return;
      }

      //saving driver data to real time database

      DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("drivers").child(firebaseDriver!.uid);
      Map driverMap = {
        "id": firebaseDriver.uid,
        "name": nameTextEditingController.text.trim(),
        "contactNum": contactNumTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "nic": nicTextEditingController.text.trim(),
        "blockStatus": "no",
      };

      // save the driver data nd pass the data to map
      // try {
      //   driverRef.set(driverMap);
      //   currentFirebaseUser = firebaseDriver;
      //   await Navigator.push(context, MaterialPageRoute(builder: ((context) => CarInfoScreen())));
      //   await Fluttertoast.showToast(msg: 'Account has been created');
      // } catch (e) {
      //   await Fluttertoast.showToast(msg: 'Driver Registration Failed!');
      // }
      driverRef.set(driverMap);
      currentFirebaseUser = firebaseDriver;
      await Navigator.push(context, MaterialPageRoute(builder: ((context) => CarInfoScreen())));
      // await Fluttertoast.showToast(msg: 'Account has been created');
      // Fluttertoast.showToast(msg: 'Account has been created');
    }

    /// passenger database - working fine

    if (widget.user == my_user.User.passenger) {
      final firebase_auth.User? firebaseUser = (await firebase_auth.FirebaseAuth.instance
              .createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      )
              .catchError(
        (errorMsg) {
          // Fluttertoast.showToast(msg: 'Pessenger Registration Failed!');
          // Navigator.pop(context);
        },
      ))
          .user;

      if (context.mounted) {
        await Fluttertoast.showToast(msg: 'Account has been created');
        // Navigator.pop(context);
      } else {
        await Fluttertoast.showToast(msg: 'Pessenger Registration Failed!');
        return;
      }

      // saving passenger data to real time database
      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("passengers").child(firebaseUser!.uid);
      Map usersMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "contactNum": contactNumTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        // "password":passwordTextEditingController.text.trim(),
        "blockStatus": "no",
      };

      usersRef.set(usersMap);
      //   currentFirebaseUser = firebaseUser;
      await Fluttertoast.showToast(msg: 'Your Car Details Successfully Saved');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => const LoginScreen(
                    user: my_user.User.passenger,
                  ))));
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
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Create An Account',
                style: Theme.of(context).textTheme.bold24,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Name',
                controller: nameTextEditingController,
                keyBoardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Contact Number',
                controller: contactNumTextEditingController,
                keyBoardType: TextInputType.phone,
              ),
              if (widget.user == my_user.User.driver) const SizedBox(height: 16),
              if (widget.user == my_user.User.driver)
                CustomTextField(
                  label: 'National ID Card',
                  controller: nicTextEditingController,
                ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 48),
              FillButton(
                onTapped: () {
                  checkIfNetworkIsAvailable();
                  signupvalidateForm();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => widget.user == my_user.User.passenger ? const PHomeScreen() : const DHomeScreen(),
                  //   ),
                  // );
                },
                text: 'SIGN UP',
                color: Palette.white,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ALREADY HAVE AN ACCOUNT?   ', style: Theme.of(context).textTheme.normal13),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(user: widget.user),
                        ),
                      );
                    },
                    child: Text(
                      'LOGIN',
                      style: Theme.of(context).textTheme.bold13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
