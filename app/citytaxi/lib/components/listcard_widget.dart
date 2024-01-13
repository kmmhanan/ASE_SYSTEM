import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class HireCard extends StatelessWidget {
  final String fromAddress;
  final String toAddress;
  final String distance;

  const HireCard(
      {super.key,
      required this.fromAddress,
      required this.toAddress,
      required this.distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Palette.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 85,
                child: Text(
                  'From: ',
                  style: Theme.of(context).textTheme.bold13.copyWith(
                        color: Palette.black,
                      ),
                ),
              ),
              Expanded(
                child: Text(
                  fromAddress,
                  style: Theme.of(context).textTheme.normal13.copyWith(
                        color: Palette.black,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: [
            SizedBox(
                width: 85,
                child: Text(
                  'To: ',
                  style: Theme.of(context).textTheme.bold13.copyWith(
                        color: Palette.black,
                      ),
                )),
            Expanded(
                child: Text(
              toAddress,
              style: Theme.of(context).textTheme.normal13.copyWith(
                    color: Palette.black,
                  ),
            )),
          ]),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 85,
                child: Text(
                  'Distance: ',
                  style: Theme.of(context).textTheme.bold13.copyWith(
                        color: Palette.black,
                      ),
                ),
              ),
              Text(
                distance,
                style: Theme.of(context).textTheme.normal13.copyWith(
                      color: Palette.black,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
