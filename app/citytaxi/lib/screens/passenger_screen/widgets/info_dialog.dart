import 'package:citytaxi/constants/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restart_app/restart_app.dart';

class InfoDialog extends StatefulWidget {
  String? title, description;
  InfoDialog({super.key, this.title, this.description});

  @override
  State<InfoDialog> createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.black87,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.black54,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  widget.title.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Palette.white),
                ),
                const SizedBox(height: 27),
                Text(
                  widget.description.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 202,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Restart.restartApp();
                    },
                    child: const Text("OK"),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
