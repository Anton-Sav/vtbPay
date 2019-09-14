import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QrRenderer extends StatefulWidget {
  final String invoiceId;
  final String address;
  final int amount;

  const QrRenderer({
    @required this.invoiceId,
    @required this.address,
    @required this.amount,
  });

  @override
  State<StatefulWidget> createState() => GenerateQrCode();
}

class GenerateQrCode extends State<QrRenderer> {

  GlobalKey globalKey = new GlobalKey();
  String _data = "Hello NetworkOnMainThreadException";

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return RepaintBoundary(
      key: globalKey,
      child: QrImage(
        data: _data,
        size: 0.5 * bodyHeight,
      ),
    );
  }

}
