import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/student/models/user.dart';
import 'package:school_management_system/student/resources/Parent/stparentmodel.dart';

class ParentApi {
  static getStudents(String email) async {
    List allStudents = [];

    print('stfffffffffffffffffffffffff');
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .where('parent_email', isEqualTo: email)
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          allStudents.add(
            StudentP(
              id: value.docs[i]['uid'],
              firstName: value.docs[i]['first_name'],
              lastName: value.docs[i]['last_name'],
              urlAvatar: value.docs[i]['urlAvatar'],
              fees: value.docs[i]['fees'].toString(),
              phone: value.docs[i]['phone'].toString(),
              parentPhone: value.docs[i]['parent_phone'].toString(),
              studentClass: value.docs[i]['class_name'],
              studentGrade: value.docs[i]['grade'].toString(),
              average: value.docs[i]['grade_average'],
              email: value.docs[i]['email'],
              classid: value.docs[i]['class_id'],
            ),
          );
        }
      });
      print(allStudents);
      print('stparrrrrrrrrrrrrrrr');
      return allStudents;
    } catch (e) {
      print('erorrrrrrrrrrrrrr');
      print(e);
    }
  }
}
