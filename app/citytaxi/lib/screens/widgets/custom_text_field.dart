import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.maxLine,
    this.textInputAction,
    this.keyBoardType,
    this.hintText,
    this.fontStyle,
  });

  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLine;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Palette.white),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.normal16),
        const SizedBox(height: 8),
        SizedBox(
          height: 56,
          child: TextFormField(
            controller: controller,
            validator: validator,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            maxLines: maxLine,
            textInputAction: textInputAction,
            keyboardType: keyBoardType ?? TextInputType.text,
            decoration: InputDecoration(
              border: inputBorder,
              focusedBorder: inputBorder,
              enabledBorder: inputBorder,
              disabledBorder: inputBorder,
              hintText: hintText,
              hintStyle: TextStyle(fontStyle: fontStyle),
            ),
            style: Theme.of(context).textTheme.normal16.copyWith(height: 1.0),
            cursorColor: Palette.white,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
          ),
        ),
      ],
    );
  }
}
