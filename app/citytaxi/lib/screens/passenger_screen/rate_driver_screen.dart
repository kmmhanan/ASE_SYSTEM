import 'package:citytaxi/components/custom_buttons.dart';
import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:citytaxi/utils/global/global_variables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RateDriverScreen extends StatefulWidget {
  String? assignedDriverId;

  RateDriverScreen({this.assignedDriverId});
  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      //backgroundColor: Palette.white,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(color: Palette.mainColor60, borderRadius: BorderRadius.circular(6)),
        child: Column(
          //  mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 22.0),
            Text(
              'How is your trip?',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 22.0),
            const Divider(
              height: 1.5,
              color: Colors.grey,
              thickness: 1.0,
            ),
            const Expanded(child: SizedBox()),
            RatingBar.builder(
              // maxRating: countRatingStars,
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 46,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(Icons.star_rounded, color: Colors.amber),
              onRatingUpdate: (valueOfStarsChoosed) {
                countRatingStars = valueOfStarsChoosed;
                if (countRatingStars == 1) {
                  setState(() {
                    titleStarsRating = "Unsatisfactory Service";
                  });
                }
                if (countRatingStars == 2) {
                  setState(() {
                    titleStarsRating = "Fair Service";
                  });
                }
                if (countRatingStars == 3) {
                  setState(() {
                    titleStarsRating = "Good Service";
                  });
                }
                if (countRatingStars == 4) {
                  setState(() {
                    titleStarsRating = "Exceptional Service";
                  });
                }
                if (countRatingStars == 5) {
                  setState(() {
                    titleStarsRating = "Outstanding Service";
                  });
                }
              },
            ),
            const SizedBox(height: 18.0),
            Text(
              titleStarsRating,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FillButton(
                onTapped: () {
                  DatabaseReference rateDriverRef = FirebaseDatabase.instance.ref().child("drivers").child(widget.assignedDriverId!).child("ratings");

                  rateDriverRef.once().then((snap) {
                    if (snap.snapshot.value == null) {
                      rateDriverRef.set(countRatingStars.toString());

                      Navigator.pop(context);
                    } else {
                      double pastRatings = double.parse(snap.snapshot.value.toString());
                      double newAverageRatings = (pastRatings + countRatingStars) / 2;
                      rateDriverRef.set(newAverageRatings.toString());

                      Navigator.pop(context);
                    }

                    // Fluttertoast.showToast(msg: "Please Restart App Now");
                  });
                },
                text: 'Submit',
                color: Palette.white,
              ),
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
