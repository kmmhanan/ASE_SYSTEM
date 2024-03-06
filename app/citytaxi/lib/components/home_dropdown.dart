import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class HomeDropdown extends StatelessWidget {
  const HomeDropdown({
    super.key,
    required this.name,
    required this.icon,
    this.goTo,
    this.onSignOut,
  });

  final Widget? goTo;
  final IconData icon;
  final String name;
  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (name == 'Signout' && onSignOut != null) {
          onSignOut!(); // If onSignOut is provided, call it
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => goTo!, // Navigate to goTo if provided
            ),
          );
        }
      },
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 32,
              child: Icon(
                icon,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              name,
              style: Theme.of(context).textTheme.normal16.copyWith(
                    color: Palette.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
