import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/teacher/Teacher_global_info/Subjects_of_teacher/TeacherSubjects.dart';
import 'package:school_management_system/teacher/model/subject/TeacherSubjectModel.dart';

class TSubjetcsServices {
  getTeacherSubjectForClass(String grade, String classId) async {
    var subjectList = [];
    var subjectListId = [];
    try {
      print('Wtf Is that');
      print(grade);
      print(classId);
      await FirebaseFirestore.instance
          .collection('relation')
          .where('grade', isEqualTo: grade)
          .where('teacher', isEqualTo: UserInformation.User_uId)
          .where('classrooms', arrayContains: classId)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          subjectListId.add(element.data()['subject'].toString());
        });
      });

      print('subjects is ');
      print(subjectListId);

      for (var item in subjectListId) {
        await FirebaseFirestore.instance
            .collection('subject')
            .doc(item.toString())
            .get()
            .then((value) {
          var item = TeacherSubjectModel(
            subjectName: value.data()!['name'],
            subjectId: value.data()!['id'],
            grade: value.data()!['subject_grade'],
          );
          subjectList.add(item);
          TeacherSubjects.subjectsList.add(item);
        });
      }

      return subjectList;
    } catch (e) {
      return [];
    }
  }

  static getAllTeacherSubject() async {
    var subjectList = [];
    var subjectListId = [];
    try {
      print('Wtf Is that');

      await FirebaseFirestore.instance
          .collection('relation')
          .where('teacher', isEqualTo: UserInformation.User_uId)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          subjectListId.add(element.data()['subject'].toString());
        });
      });

      print('subjects is ');
      print(subjectListId);

      for (var item in subjectListId) {
        await FirebaseFirestore.instance
            .collection('subject')
            .doc(item.toString())
            .get()
            .then((value) {
          var item = TeacherSubjectModel(
            subjectName: value.data()!['name'],
            subjectId: value.data()!['id'],
            grade: value.data()!['subject_grade'],
          );
          subjectList.add(item);
          TeacherSubjects.subjectsList.add(item);
        });
      }

      return subjectList;
    } catch (e) {
      return [];
    }
  }
}
