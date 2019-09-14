import 'package:flutter/material.dart';
import 'package:vtb_pay_app/design.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfilePage'),
      ),
      body: Text(
        'Чекаем профиль ',
        style: optionStyle,
      ),
    );
  }
}
