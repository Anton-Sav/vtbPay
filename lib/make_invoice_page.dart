import 'package:flutter/material.dart';

class MakeInvoicePage extends StatelessWidget {
  final int paymentSum;

  const MakeInvoicePage({@required this.paymentSum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MakeInvoicePage'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Платёж на $paymentSum руб'),
            Text('TODO'),
          ],
        ),
      ),
    );
  }
}
