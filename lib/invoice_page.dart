import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InvoicePage'),
      ),
      body: TextField(
        decoration: InputDecoration(
          labelText: 'Введите общую сумму счёта',
        ),
      ),
    );
  }
}
