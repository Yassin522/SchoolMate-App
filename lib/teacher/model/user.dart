import 'package:meta/meta.dart';

import '../resources/chat/chat_utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  final String? idUser;
  final String? first_name;
  final String? last_name;
  final String? urlAvatar;
  final DateTime? lastMessageTime;


  const User({
    this.idUser,
   required this.first_name,
   required this.last_name,
    required this.urlAvatar,
     this.lastMessageTime,
  });

  User copyWith({
    String? idUser,
    String? name,
    String? urlAvatar,
    String? lastMessageTime,
    String? first_name,
    String? last_name,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        first_name: first_name ?? this.first_name,
        last_name: last_name ?? this.last_name,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime as DateTime? ?? this.lastMessageTime,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        idUser: json['uid'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        urlAvatar: json['urlAvatar'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'uid': idUser,
        'first_name': first_name,
        'last_name':last_name,
        'urlAvatar': urlAvatar,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime!),
      };
}
