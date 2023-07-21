import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/public/config/user_information.dart';

import '../../../teacher/model/subject/TMarksModel.dart';
import '../../../teacher/resources/TsubjectsServices/TMarksServices.dart';

class StdProfileServices {
  getStudentMarks(String grade, String classId, String uid) async {
    var subjectListId = UserInformation.Subjects;
    var subjectMarkLits = [];
    try {
      var markServices = TMarksServices();

      for (var subjectid in subjectListId) {
        var subjectName = subjectid.name;
        var subjectId = subjectid.id;
        var test = await markServices.getTestMark(subjectid.id, grade, uid);
        var homework =
            await markServices.getHomeWorkMark(subjectid.id, grade, uid);
        var exam1 = await markServices.getExam1kMark(subjectid.id, grade, uid);
        var exam2 = await markServices.getExam2kMark(subjectid.id, grade, uid);
        try {
          subjectMarkLits.add(StudentMarkInprofile(
            subjectname: subjectName,
            test: test,
            homework: homework,
            exam1: exam1,
            exam2: exam2,
          ));
        } catch (e) {
          continue;
        }
      }
      return subjectMarkLits;
    } catch (e) {
      print(e);
      return subjectMarkLits;
    }
  }
}
