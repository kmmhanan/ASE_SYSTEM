import 'package:citytaxi/components/baground_container.dart';
import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/custom_text_field.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/models/user_model.dart';
import 'package:citytaxi/screens/login_screen.dart';
import 'package:citytaxi/utils/firebase_auth_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  final TextEditingController carModelTextEditingController = TextEditingController();
  final TextEditingController carNumTextEditingController = TextEditingController();

  List<String> carTypesList = ["cityTaxi-x", "cityTaxi-go", "bike"];
  String? selectedCarType;

  saveCarInfo() {
    DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("drivers").child(currentFirebaseUser!.uid).child("car_details");

    Map driverCarInfoMap = {
      "car_model": carModelTextEditingController.text.trim(),
      "car_num": carNumTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    driverRef.set(driverCarInfoMap);
    Fluttertoast.showToast(msg: 'Car Details has been saved. Congratulations');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => const LoginScreen(
                  user: User.driver,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BagroundContainer(
        heading: ' ',
        bodyWidgets: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "Enter Car Details",
                  style: Theme.of(context).textTheme.normal18,
                ),
                Expanded(
                  child: Image.asset(
                    'assets/logo/images/carInfo.png',
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Your Car Model',
                  controller: carModelTextEditingController,
                ),
                CustomTextField(
                  label: 'Your Car Number',
                  controller: carNumTextEditingController,
                ),
                const SizedBox(height: 16),
                DropdownButton(
                  iconSize: 26,
                  dropdownColor: Palette.black,
                  hint: Text(
                    "Please choose Car Type",
                    style: Theme.of(context).textTheme.normal13.copyWith(color: Colors.grey),
                  ),
                  value: selectedCarType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCarType = newValue.toString();
                    });
                  },
                  items: carTypesList.map((car) {
                    return DropdownMenuItem(
                      value: car,
                      child: Text(
                        car,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                FillButton(
                  onTapped: () {
                    if (carModelTextEditingController.text.isNotEmpty && carNumTextEditingController.text.isNotEmpty && selectedCarType != null) {
                      saveCarInfo();
                    }
                  },
                  text: 'Save Now',
                  color: Palette.mainColor30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
