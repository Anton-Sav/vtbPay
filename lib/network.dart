import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vtb_pay_app/model/InvoiceRequest.dart';
import 'package:vtb_pay_app/model/session.dart';

final _baseUrl = 'http://89.208.84.235:31080';
final _apiUrl = '$_baseUrl/api/v1';

Future<String> makeSession({@required String address}) async {
  final response = await http.post(
    '$_apiUrl/session',
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
      SessionRequest(
        address: address,
        deviceId: '1',
        deviceType: 1,
      ),
    ),
  );

  print("Getting session request: ${response.statusCode}");
  print("Session response: ${response.body}");

  final data = json.decode(response.body);
  return data['data'];
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
