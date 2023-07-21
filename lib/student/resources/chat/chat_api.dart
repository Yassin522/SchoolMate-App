import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:school_management_system/student/resources/chat/chat_data.dart';

import '../../models/chat/message.dart';
import '../../models/user.dart';
import 'chat_utils.dart';
import 'dart:io';

class FirebaseApi {
  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection('teacher')
      .orderBy('first_name')
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String? idUser, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');

    final newMessage = Message(
      idUser: myId,
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
      uiD: idUser,
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('teacher');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String? idUser) =>
      FirebaseFirestore.instance
          .collectionGroup('messages')
          .where('uid', whereIn: [idUser, myId])
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future addRandomUsers(List<User> users) async {
    final refUsers = FirebaseFirestore.instance.collection('teacher');

    final allUsers = await refUsers.get();

    for (final user in users) {
      final userDoc = refUsers.doc();
      final newUser = user.copyWith(idUser: userDoc.id);

      await userDoc.set(newUser.toJson());
    }
  }

  static LoadNameFromApi(String name) async {
    List<User> founded = [];
    final allusers = await FirebaseFirestore.instance
        .collection('teacher')
        .where('first_name', isEqualTo: name)
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        founded.add(
          User(
            first_name: value.docs[i]['first_name'],
            last_name: value.docs[i]['last_name'],
            urlAvatar: value.docs[i]['urlAvatar'],
            idUser: value.docs[i]['uid'],
          ),
        );
      }
    });

    print(founded);
    return founded;
  }

  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
