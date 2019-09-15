import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrRenderer extends StatelessWidget {
  final String invoiceId;
  final String address;
  final int amount;
  final int currencyCode = 810;

  const QrRenderer({
    @required this.invoiceId,
    @required this.address,
    @required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return RepaintBoundary(
      //key: globalKey,
      child: QrImage(
        data: jsonEncode({
          'address': address,
          'invoiceId': invoiceId,
          'amount': amount,
          'currencyCode': currencyCode
        }),
        size: 0.5 * bodyHeight,
      ),
    );
  }
}
