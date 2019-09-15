import 'package:flutter/material.dart';
import 'package:vtb_pay_app/design.dart';
import 'package:vtb_pay_app/utils.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopNavigator(
      child: HistoryPage(),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'И С Т О Р И Я',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(255, 71, 58, 50),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Text(
        'Смотрим историю',
        style: optionStyle,
      ),
    );
  }
}
