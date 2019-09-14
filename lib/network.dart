import 'package:flutter/cupertino.dart';

Future<void> makeInvoice({
  @required String recipientWalletId,
  @required int paymentAmount,
  @required String description,
  @required String invoiceId,
}) async {
  await Future.delayed(Duration(seconds: 1));
}
