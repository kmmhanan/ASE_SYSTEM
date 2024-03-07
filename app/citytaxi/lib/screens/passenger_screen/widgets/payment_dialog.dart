import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/utils/methods/common_methods.dart';
import 'package:flutter/material.dart';

class PaymentDialog extends StatefulWidget {
  String fareAmount;
  PaymentDialog({super.key, required this.fareAmount});

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  CommonMethods cMethods = CommonMethods();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Palette.white,
      child: Container(
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(color: Palette.mainColor60, borderRadius: BorderRadius.circular(6)),
        child: Column(
          children: [
            const SizedBox(height: 21),
            const Text(
              "PAY CASH",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 21),

            const Divider(
              height: 1.5,
              color: Colors.white,
              thickness: 1.0,
            ),
            //   const SizedBox(height: 16),
            const Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "This is fare Amount (LKR ${widget.fareAmount}) you have to pay to the driver.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Expanded(child: SizedBox()),
            Text(
              "LKR ${widget.fareAmount}",
              style: const TextStyle(color: Colors.grey, fontSize: 36, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 16),
            const Expanded(child: SizedBox()),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FillButton(
                onTapped: () {
                  Navigator.pop(context, "paid");
                },
                text: "PAY CASH",
                color: Palette.mainColor30,
              ),
            ),

            const SizedBox(height: 41),
          ],
        ),
      ),
    );
  }
}
