import 'package:flutter/material.dart';

import '../resources/chat/chat_utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String? idUser;
  final String? urlAvatar;
  final String? username;
  final String? message;
  final DateTime? createdAt;
  final String? uiD;

  const Message({
    required this.idUser,
    required this.urlAvatar,
    required this.username,
    required this.message,
    required this.createdAt,
    required this.uiD,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        idUser: json['idUser'],
        urlAvatar: json['urlAvatar'],
        username: json['username'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
        uiD: json['uid']
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'urlAvatar': urlAvatar,
        'username': username,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt!),
        'uid':uiD
      };
}
