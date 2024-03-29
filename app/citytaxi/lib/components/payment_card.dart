import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'Name: ',
                  style: Theme.of(context).textTheme.bold13.copyWith(
                        color: Palette.black,
                      ),
                ),
              ),
              Expanded(
                child: Text(
                  'Dilini Buddhika',
                  style: Theme.of(context).textTheme.normal13.copyWith(
                        color: Palette.black,
                      ),
                ),
              ),
            ],
          ),
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
                '45km',
                style: Theme.of(context).textTheme.normal13.copyWith(
                      color: Palette.black,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 85,
                child: Text(
                  'Ride Time: ',
                  style: Theme.of(context).textTheme.bold13.copyWith(
                        color: Palette.black,
                      ),
                ),
              ),
              Expanded(
                child: Text(
                  '0hrs 34m',
                  style: Theme.of(context).textTheme.normal13.copyWith(
                        color: Palette.black,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}








// import 'package:citytaxi/constants/strings.dart';
// import 'package:flutter/material.dart';

// class DetailsCardWidget extends StatelessWidget {
//   const DetailsCardWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             Row(children: [
//               SizedBox(width: 85, child: Text('Name:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
//               const SizedBox(width: 16),
//               Expanded(child: Text("Dilini Buddhika", style: Theme.of(context).textTheme.bold15)),
//             ]),
//             SizedBox(height: 12),
//             Row(children: [
//               SizedBox(width: 85, child: Text('Contact:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
//               const SizedBox(width: 16),
//               Expanded(child: Text("+94 77 123 4567", style: Theme.of(context).textTheme.bold15)),
//             ]),
//             SizedBox(height: 12),
//             Row(children: [
//               SizedBox(width: 85, child: Text('From:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
//               const SizedBox(width: 16),
//               Expanded(
//                   child: Text("23/2, Athapttu Mawatha, Dehiwala 23/2, Athapttu Mawatha, Dehiwala 23/2, Athapttu Mawatha, Dehiwala ", style: Theme.of(context).textTheme.bold15)),
//             ]),
//             SizedBox(height: 12),
//             Row(children: [
//               SizedBox(width: 85, child: Text('To:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
//               const SizedBox(width: 16),
//               Expanded(child: Text("32, Dr. Pons Rd, Bambalpitiya ", style: Theme.of(context).textTheme.bold15)),
//             ]),
//             SizedBox(height: 12),
//             Row(children: [
//               SizedBox(width: 85, child: Text('Distance:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
//               const SizedBox(width: 16),
//               Expanded(child: Text("45km", style: Theme.of(context).textTheme.bold15)),
//             ]),
//             SizedBox(height: 12),
//             Row(children: [
//               SizedBox(width: 85, child: Text('Time:', textAlign: TextAlign.right, style: Theme.of(context).textTheme.bold14)),
//               const SizedBox(width: 16),
//               Expanded(child: Text("-", style: Theme.of(context).textTheme.bold15)),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }


