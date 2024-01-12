import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class ListCardWidget extends StatelessWidget {
  final String fromAddress;
  final String toAddress;
  final String distance;

  const ListCardWidget({super.key, required this.fromAddress, required this.toAddress, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(children: [
              SizedBox(width: 85, child: Text('From: ', style: Theme.of(context).textTheme.bold14)),
              Expanded(child: Text(fromAddress, style: Theme.of(context).textTheme.bold15)),
            ]),
            SizedBox(height: 8),
            Row(children: [
              SizedBox(width: 85, child: Text('To: ', style: Theme.of(context).textTheme.bold14)),
              Expanded(child: Text(toAddress, style: Theme.of(context).textTheme.bold15)),
            ]),
            SizedBox(height: 8),
            Row(children: [
              SizedBox(width: 85, child: Text('Distance: ', style: Theme.of(context).textTheme.bold14)),
              Text(distance, style: Theme.of(context).textTheme.bold15),
            ])
          ],
        ),
      ),
    );
  }
}
