import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String label;
  final String value;

  const CustomCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 85,
          child: Text(
            '$label:',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bold14,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bold15,
          ),
        ),
      ],
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


