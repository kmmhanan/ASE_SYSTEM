import 'package:flutter/material.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';

class FillButton extends StatelessWidget {
  const FillButton({
    super.key,
    required this.onTapped,
    required this.text,
    required this.color,
  });

  final Function() onTapped;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.normal16.copyWith(
                  color: (color == Palette.white || color == Palette.yellow)
                      ? Palette.black
                      : Palette.white,
                ),
          ),
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  const BorderButton({
    super.key,
    required this.onTapped,
    required this.text,
  });

  final Function() onTapped;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Palette.white,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: Text(text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.normal16),
        ),
      ),
    );
  }
}
