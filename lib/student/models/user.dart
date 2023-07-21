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
  final String? email;
  final DateTime? lastMessageTime;
  final int? Class;
  final int? fees;
  final int? grade;
  final int? parentphone;
  final int? phone;

  final double? grade_average;

  const User({
    this.idUser,
    this.Class, 
    this.fees, 
    this.grade, 
    this.parentphone,
    this.phone,
    this.grade_average, 
   required this.first_name,
   required this.last_name,
    required this.urlAvatar,
     this.lastMessageTime,
     this.email,
  });

  User copyWith({
    String? idUser,
    String? name,
    String? urlAvatar,
    String? lastMessageTime,
    String? first_name,
    String? last_name,
    String? grade_average,
    int? grade,
    int? Class,
    int? fees,
    int? parentphone,
    int? phone,
    String? eamil,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        first_name: first_name ?? this.first_name,
        last_name: last_name ?? this.last_name,
        email: email ?? this.email,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime as DateTime? ?? this.lastMessageTime,
        grade_average: grade_average as double ,
        grade: grade ?? this.grade,
        Class: Class ?? this.Class,
        fees: fees ?? this.fees,
        parentphone: parentphone ?? this.parentphone,
        phone: parentphone ?? this.phone,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        idUser: json['uid'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        urlAvatar: json['urlAvatar'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
        grade_average: json['grade_average'],
        grade: json['grade'],
        Class: json['class'],
        fees: json['fees'],
        parentphone: json['parentphone'],
        phone: json['phone'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'uid': idUser,
        'first_name': first_name,
        'last_name':last_name,
        'urlAvatar': urlAvatar,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime!),
        'grade_average': grade_average,
        'grade': grade,
        'Class': Class,
        'fees': fees,
        'parentphone': parentphone,
        'phone': phone,
        'email':email,
      };
}
