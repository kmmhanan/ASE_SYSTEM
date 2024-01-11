import 'package:flutter/material.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';

class CTBlueButton extends StatelessWidget {
  const CTBlueButton({
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
          color: Palette.mainColor30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.normal16,
          ),
        ),
      ),
    );
  }
}

class CTWhiteButton extends StatelessWidget {
  const CTWhiteButton({
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
          color: Palette.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .normal16
                .copyWith(color: Palette.black),
          ),
        ),
      ),
    );
  }
}

class CTYellowButton extends StatelessWidget {
  const CTYellowButton({
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
          color: Palette.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .normal16
                .copyWith(color: Palette.black),
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
