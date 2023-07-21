import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../public/config/user_information.dart';




  Future<void> saveTokenToDatabase(String token) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('students').doc(userId).update({
      'token': FieldValue.arrayUnion([token1]),
    });
    print("============token ====================");
    print(token1);
  }

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);
  @override
  State<Message> createState() => _MessagingS();
}

var fbm = FirebaseMessaging.instance;
var token;
String token1 = '';
var uid = UserInformation.User_uId;
var serverToken =
    "AAAAQE4NoSk:APA91bEczYqDFjpz6_EPghaa6rIQlVQMhwAzK1WGMgxqupcOYvaqhEDrorp-qiw95BxHoztknovhyftDwtr4ZgYeZPo4wWI6Oo3tlxiSarvHi1BR7Tibrj7rflFFoFQucBxBRWqhz-Y0";

class _MessagingS extends State<Message> {

late String _token;

  Future<void> setupToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await saveTokenToDatabase(token!);
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
     print("Doooooooooneeeeeeeeeee");
  }
  @override
  void initState() {
    super.initState();
   //  getMessaging();
    setupToken();
  }



  getMessaging() {
    FirebaseMessaging.onMessage.listen((message) {
      print("kkkkk");
    });
  }
  @override
  Widget build(BuildContext context) {
     return Text("...");
  }


  
chatMessaging(String title, String body) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'content_type': 'application/json',
        'authorization': 'key =$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString(),
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            "name": "iii",
            "lastname": "ooo",
          },
          'to':
              " dJMU5Dh6R6O2U6QSLhsqk0:APA91bHEh-beJ1hzLkvBXwju6ben7j_jt368s0kCBEIqaAtifwVf_Gmzsn1Jlj17YgtEavE_1-6IZjMZAssO8f5v2X8nFOU7p9hk-e7DnExTEH30x1vaYROMYwvakHWE1ppOb8xRTahj"
        },
      ),
    );
  }
}
