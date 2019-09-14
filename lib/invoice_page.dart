import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Введите общую сумму счёта',
      ),
    );
  }
}
