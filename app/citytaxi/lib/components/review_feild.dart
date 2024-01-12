import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class ReviewFeild extends StatelessWidget {
  const ReviewFeild({
    super.key,
    required this.rating,
    required this.label,
  });

  final int rating;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.normal16,
        ),
        const Expanded(child: SizedBox()),
        Icon(
          Icons.star_rate_rounded,
          color: rating < 1 ? Palette.white : Palette.yellow,
          size: 32,
        ),
        Icon(
          Icons.star_rate_rounded,
          color: rating < 2 ? Palette.white : Palette.yellow,
          size: 32,
        ),
        Icon(
          Icons.star_rate_rounded,
          color: rating < 3 ? Palette.white : Palette.yellow,
          size: 32,
        ),
        Icon(
          Icons.star_rate_rounded,
          color: rating < 4 ? Palette.white : Palette.yellow,
          size: 32,
        ),
        Icon(
          Icons.star_rate_rounded,
          color: rating < 5 ? Palette.white : Palette.yellow,
          size: 32,
        ),
      ],
    );
  }
}
