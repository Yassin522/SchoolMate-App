import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/models/user.dart';

class StudentApi {
  static getinfo(String? idUser) async {
    String docID;
    List user = [];

    final ref = await FirebaseFirestore.instance
        .collection('students')
        .where('uid', isEqualTo: UserInformation.User_uId)
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        user.add(
          User(
            first_name: value.docs[i]['first_name'],
            parentphone: value.docs[i]['parent_phone'],
            last_name: value.docs[i]['last_name'],
            urlAvatar: value.docs[i]['urlAvatar'],
            fees: value.docs[i]['fees'],
            grade: value.docs[i]['grade'],
            grade_average: value.docs[i]['grade_average'],
            phone: value.docs[i]['phone'],
          ),
        );
      }
    });
    return user;
  }
}
