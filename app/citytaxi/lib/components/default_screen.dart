import 'package:citytaxi/constants/palette.dart';
import 'package:citytaxi/constants/strings.dart';
import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({
    super.key,
    required this.appBarTitle,
    required this.appBarOnPressed,
    required this.widget,
  });

  final String appBarTitle;
  final Function() appBarOnPressed;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor60,
      appBar: AppBar(
        backgroundColor: Palette.mainColor60,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Palette.white,
            size: 16,
          ),
          onPressed: appBarOnPressed,
        ),
        title: Text(
          appBarTitle,
          style: Theme.of(context).textTheme.normal16,
        ),
      ),
      body: widget,
    );
  }
}
