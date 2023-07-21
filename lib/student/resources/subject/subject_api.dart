import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/models/subject/subjectModel.dart';

class SubjectServices {
  getUserSubjects() async {
    List subjectRefrencesList = [];
    List subjectInfo = [];
    subjectRefrencesList.clear();
    subjectInfo.clear();
    try {
      await FirebaseFirestore.instance
          .collection('acadimic_year')
          .doc(UserInformation.grade.toString())
          .get()
          .then((value) {
        print(value.data()!['subject']);
        subjectRefrencesList = value.data()!['subject'];
      });
      for (var item in subjectRefrencesList) {
        var lessonsNumber = 0;
        var takenLessons = 0;
        var subjectName = '';
        var teacherName;
        var teacherRefrence;
        await FirebaseFirestore.instance
            .collection('subject')
            .doc(item.toString())
            .get()
            .then((value) {
          subjectName = value.data()?['name'];
          //lessonsNumber = value.data()?['lessons'].length ?? 0;
        });
        await FirebaseFirestore.instance
            .collection('lessons')
            .where('subject', isEqualTo: item.toString())
            .get()
            .then((value) {
          lessonsNumber = value.docs.length;
        });
        print(UserInformation.classid);
        print(item.toString());
        print(UserInformation.grade.toString());
        await FirebaseFirestore.instance
            .collection('relation')
            .where('classrooms', arrayContains: UserInformation.classid)
            .where('subject', isEqualTo: item.toString())
            .where('grade', isEqualTo: UserInformation.grade.toString())
            .get()
            .then((value) {
          value.docs.forEach((element) {
            teacherName = element.data()['teacher_name'];
          });
        });
        try {
          subjectInfo.add(SubjectModel(
            name: subjectName,
            teacherName: teacherName,
            id: item,
            lessonsNumber: lessonsNumber,
          ));
        } catch (e) {
          print(e);
          return subjectInfo;
        }
      }
      return subjectInfo;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
