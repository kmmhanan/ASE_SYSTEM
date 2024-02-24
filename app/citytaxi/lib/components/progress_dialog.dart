import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String? message;
  ProgressDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(width: 6),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Palette.white),
              ),
              const SizedBox(width: 10),
              Text(
                message!,
                style: Theme.of(context).textTheme.normal16.copyWith(color: Palette.white),
              )
            ], 
          ),
        ),
      ),
    );
  }
}
