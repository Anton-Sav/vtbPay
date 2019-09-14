import 'package:flutter/cupertino.dart';

Future<void> makeInvoice({
  @required String recipientWalletId,
  @required int paymentAmount,
  @required String description,
}) async {
  await Future.delayed(Duration(seconds: 1));
}
