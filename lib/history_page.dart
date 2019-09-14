import 'package:flutter/material.dart';
import 'package:vtb_pay_app/design.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HistoryPage'),
      ),
      body: Text(
        'Смотрим историю',
        style: optionStyle,
      ),
    );
  }
}
