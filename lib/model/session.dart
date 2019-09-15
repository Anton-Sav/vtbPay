import 'package:flutter/cupertino.dart';

class SessionRequest {
  final List<String> addresses;
  final String deviceId;
  final int deviceType;

  SessionRequest({
    @required String address,
    @required this.deviceId,
    @required this.deviceType,
  }) : addresses = [address];

/*
  SessionRequest.fromJson(Map<String, dynamic> json):
        name = json['name'],
        email = json['email'];
*/

  Map<String, dynamic> toJson() =>
      {
        'addresses': addresses,
        'deviceId': deviceId,
        'deviceType': deviceType
      };
}