import 'package:flutter/material.dart';

class QrRenderer extends StatelessWidget {
  final String invoiceId;
  final String address;
  final int amount;

  const QrRenderer({
    @required this.invoiceId,
    @required this.address,
    @required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Text('[QR]');
  }
}
