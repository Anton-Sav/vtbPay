import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

// flutter pub run build_runner build

const currencyCode = 810; // rub

@immutable
@JsonSerializable()
class InvoiceStatus {
  final String number;
  final int currencyCode;
  final double amount;
  final String description;
  final String recipient, payer;
  final int state;
  final int created, updated;
  final String owner;
  final int errorCode;

  InvoiceStatus({
    @required this.number,
    @required this.currencyCode,
    @required this.amount,
    @required this.description,
    @required this.recipient,
    @required this.payer,
    @required this.state,
    @required this.created,
    @required this.updated,
    @required this.owner,
    @required this.errorCode,
  });

  factory InvoiceStatus.fromJson(Map<String, dynamic> json) =>
      _$InvoiceStatusFromJson(json);
}
