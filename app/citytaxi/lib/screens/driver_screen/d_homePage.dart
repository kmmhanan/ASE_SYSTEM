import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/components/default_screen.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/screens/driver_screen/driver_availablelist.dart';
import 'package:citytaxi/screens/passenger_screen/nearby_drivers.dart';
import 'package:citytaxi/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class DHomeScreen extends StatefulWidget {
  const DHomeScreen({super.key});

  @override
  State<DHomeScreen> createState() => _DHomeScreenState();
}

class _DHomeScreenState extends State<DHomeScreen> {
  bool isAvailable = true;
  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   backgroundColor: Palette.mainColor60,
        //   appBar: AppBar(
        //     backgroundColor: Palette.mainColor60,
        //     elevation: 0,
        //     //  automaticallyImplyLeading: false,
        //     leading: IconButton(
        //         icon: Icon(Icons.arrow_back_ios_new, color: Palette.white),
        //         onPressed: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => WelcomeScreen()));
        //         }),
        //     title: Text('Back', style: TextStyle(color: Palette.white)),
        //   ),
        //   body: Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        //     clipBehavior: Clip.antiAlias,
        //     decoration: BoxDecoration(
        //       color: Palette.black.withOpacity(0.3),
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text('Drive more, Earn more',
        //             style: Theme.of(context).textTheme.normal24),
        //         const SizedBox(height: 24),
        //         ClipRRect(
        //           borderRadius: BorderRadius.circular(16.0),
        //           child: Image.asset(
        //             'assets/logo/images/map.png',
        //             height: 350,
        //             width: double.infinity,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //         const SizedBox(height: 24),
        //         Text(
        //           'Drive Safe... 😊',
        //           textAlign: TextAlign.center,
        //           style: Theme.of(context).textTheme.normal16,
        //         ),
        //       ],
        //     ),
        //   ),
        //   bottomNavigationBar: Container(
        //     color: Palette.mainColor60,
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: [
        //         if (!isAvailable)
        //           InkWell(
        //             onTap: () {
        //               Navigator.push(context,
        //                   MaterialPageRoute(builder: (context) => DriverList()));
        //             },
        //             child: Container(
        //               height: 56,
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(12),
        //                   border: Border.all(color: Colors.white)),
        //               child: Center(
        //                 child: Text('View List',
        //                     style: Theme.of(context).textTheme.normal16),
        //               ),
        //             ),
        //           ),
        //         const SizedBox(height: 22),
        //         InkWell(
        //           onTap: () {
        //             setState(() {
        //               isAvailable = !isAvailable;
        //             });
        //           },
        //           child: Container(
        //             height: 56,
        //             decoration: BoxDecoration(
        //                 color: isAvailable ? Palette.green : Palette.red,
        //                 borderRadius: BorderRadius.circular(12)),
        //             child: Center(
        //               child: Text(isAvailable ? 'Available' : 'BUSY',
        //                   style: Theme.of(context).textTheme.normal16),
        //               //    Text('BUSY', style: Theme.of(context).textTheme.normal16),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(height: 22),
        //         InkWell(
        //           onTap: () {},
        //           child: Center(
        //             child: Text('Change Status',
        //                 style: Theme.of(context).textTheme.normal16),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // );
        Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Palette.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ),
            );
          },
        ),
        title: Text(
          'Back',
          style: Theme.of(context).textTheme.normal16,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 48),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                color: Palette.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    'Drive More, Earn More.',
                    style: Theme.of(context).textTheme.bold18,
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/logo/images/map.png',
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Drive Safe... 😊',
                    style: Theme.of(context).textTheme.normal16,
                  ),
                ],
              ),
            ),
            Text(
              'Change Status',
              style: Theme.of(context).textTheme.normal16,
            )
          ],
        ),
      ),
    );
  }
}
