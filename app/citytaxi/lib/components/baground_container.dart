import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class BagroundContainer extends StatelessWidget {
  const BagroundContainer(
      {super.key, required this.heading, required this.bodyWidgets});

  final List<Widget> bodyWidgets;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Palette.black.withOpacity(0.3),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
        ),
        child: Column(
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.bold16,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(children: bodyWidgets),
            ),
          ],
        ),
      ),
    );
  }
}
