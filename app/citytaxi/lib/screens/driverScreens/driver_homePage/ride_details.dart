import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driverScreens/d_welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RideDetailsPage extends StatelessWidget {
  const RideDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
        //  automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Palette.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DWelcomeScreen()));
            }),
        title: Text('Back', style: TextStyle(color: Palette.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset(
              'assets/logo/images/ridedetails.png',
              height: 250,
            ),
          ),
          Container(
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Center(child: Text('Ride Details', style: Theme.of(context).textTheme.normal16)),
                  const SizedBox(height: 18),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(children: [
                            SizedBox(width: 85, child: Text('Name:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
                            const SizedBox(width: 16),
                            Expanded(child: Text("Dilini Buddhika", style: Theme.of(context).textTheme.bold15)),
                          ]),
                          SizedBox(height: 12),
                          Row(children: [
                            SizedBox(width: 85, child: Text('Contact:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
                            const SizedBox(width: 16),
                            Expanded(child: Text("+94 77 123 4567", style: Theme.of(context).textTheme.bold15)),
                          ]),
                          SizedBox(height: 12),
                          Row(children: [
                            SizedBox(width: 85, child: Text('From:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
                            const SizedBox(width: 16),
                            Expanded(
                                child: Text("23/2, Athapttu Mawatha, Dehiwala 23/2, Athapttu Mawatha, Dehiwala 23/2, Athapttu Mawatha, Dehiwala ",
                                    style: Theme.of(context).textTheme.bold15)),
                          ]),
                          SizedBox(height: 12),
                          Row(children: [
                            SizedBox(width: 85, child: Text('To:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
                            const SizedBox(width: 16),
                            Expanded(child: Text("32, Dr. Pons Rd, Bambalpitiya ", style: Theme.of(context).textTheme.bold15)),
                          ]),
                          SizedBox(height: 12),
                          Row(children: [
                            SizedBox(width: 85, child: Text('Distance:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
                            const SizedBox(width: 16),
                            Expanded(child: Text("45km", style: Theme.of(context).textTheme.bold15)),
                          ]),
                          SizedBox(height: 12),
                          Row(children: [
                            SizedBox(width: 85, child: Text('Time:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
                            const SizedBox(width: 16),
                            Expanded(child: Text("-", style: Theme.of(context).textTheme.bold15)),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => DriverList()));
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white)),
                child: Center(
                  child: Text('Call', style: Theme.of(context).textTheme.normal16),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              height: 56,
              decoration: BoxDecoration(color: Palette.mainColor30, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text('Waiting', style: Theme.of(context).textTheme.normal16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
