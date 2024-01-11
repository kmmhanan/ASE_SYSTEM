import 'package:flutter/material.dart';

class CustomText extends Text {
  final String text;
  final TextOverflow? textOverflow;
  final int? maxLine;
  final TextAlign textAlign;
  final bool? isCenter, softWrap;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final double? height;
  CustomText({
    required this.text,
    this.textOverflow,
    this.maxLine,
    this.textAlign = TextAlign.start,
    this.softWrap,
    this.isCenter,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textDecoration,
    this.height,
  }) : super(text,
            overflow: textOverflow,
            maxLines: maxLine,
            textAlign: isCenter != null ? TextAlign.center : textAlign,
            softWrap: softWrap ?? true,
            style: TextStyle(
              color: color,
              fontSize: fontSize != null ? (fontSize - 1.0) : 14 - 1.0,
              fontWeight: fontWeight,
              height: height,
              decoration: textDecoration,
              fontStyle: fontStyle,
            ));
}
