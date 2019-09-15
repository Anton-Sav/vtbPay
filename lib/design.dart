import 'package:flutter/material.dart';
import 'package:vtb_pay_app/assets.dart';

const TextStyle optionStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

class MyColors {
  MyColors._();

  static const red = Color.fromRGBO(255, 71, 58, 50);
}

class MyAppBar extends AppBar {
  MyAppBar(String title) : super(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontFamily: fontFamilyMontserrat,
        color: MyColors.red,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
  );
}
