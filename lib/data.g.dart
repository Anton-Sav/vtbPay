// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceStatus _$InvoiceStatusFromJson(Map<String, dynamic> json) {
  return InvoiceStatus(
    number: json['number'] as String,
    currencyCode: json['currencyCode'] as int,
    amount: json['amount'] as double,
    description: json['description'] as String,
    recipient: json['recipient'] as String,
    payer: json['payer'] as String,
    state: json['state'] as int,
    created: json['created'] as int,
    updated: json['updated'] as int,
    owner: json['owner'] as String,
    errorCode: json['errorCode'] as int,
  );
}

Map<String, dynamic> _$InvoiceStatusToJson(InvoiceStatus instance) =>
    <String, dynamic>{
      'number': instance.number,
      'currencyCode': instance.currencyCode,
      'amount': instance.amount,
      'description': instance.description,
      'recipient': instance.recipient,
      'payer': instance.payer,
      'state': instance.state,
      'created': instance.created,
      'updated': instance.updated,
      'owner': instance.owner,
      'errorCode': instance.errorCode,
    };
