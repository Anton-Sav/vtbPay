import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vtb_pay_app/model/InvoiceRequest.dart';
import 'package:vtb_pay_app/model/session.dart';

Future<String> makeSession({@required String address}) async {
  var response = await http.post('http://89.208.84.235:31080/api/v1/session',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(SessionRequest(address: address, deviceId: '1', deviceType: 1)));

  print("Getting session request: ${response.statusCode}");
  print("Session response: ${response.body}");

  return response.body;
}

Future<void> makeInvoice({
  @required String FPSID,
  @required String recipientWalletId,
  @required int paymentAmount,
  @required String description,
  @required String invoiceId,
}) async {
  var response =
      await http.post('http://89.208.84.235:31080/api/v1/invoice/', headers: {
    'Content-Type': 'application/json',
    'FPSID': FPSID
  }, body: jsonEncode(InvoiceRequest(paymentAmount, 810, description, invoiceId, recipientWalletId)));

  print("Posting new invoice request: ${response.statusCode}");
  print("Invoice response: ${response.body}");
}
