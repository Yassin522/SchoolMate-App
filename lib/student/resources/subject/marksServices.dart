import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/models/Subjects/SubjectsModel.dart';

class MarkServices {
  getExam1Result(String subjectId) async {
    var exam1Result = MarksModel();
    print('Helllo');
    print(UserInformation.User_uId);
    print(subjectId);
    var markDoc = await FirebaseFirestore.instance
        .collection('exam1')
        .where('student_id', isEqualTo: UserInformation.User_uId)
        .where('subject_id', isEqualTo: subjectId)
        .where('session', isEqualTo: 1)
        .get();

    markDoc.docs.forEach((element) {
      exam1Result.title = 'Exam1';
      exam1Result.mark = element.data()['result'];
      exam1Result.fmark = element.data()['final_mark'];
    });

    if (exam1Result != null)
      print(exam1Result.title);
    else
      print('is fucking null');

    return exam1Result;
  }

  getTestsResult(String subjectId) async {
    var testResult = MarksModel();
    var markDoc = await FirebaseFirestore.instance
        .collection('tests')
        .where('student_id', isEqualTo: UserInformation.User_uId)
        .where('subject_id', isEqualTo: subjectId)
        .where('session', isEqualTo: 1)
        .get();
    markDoc.docs.forEach((element) {
      testResult.title = 'Tests';
      testResult.mark = element.data()['result'];
      testResult.fmark = element.data()['final_mark'];
    });

    if (testResult != null)
      print(testResult.title);
    else
      print('is fucking null');

    return testResult;
  }

  getHomeworksResult(String subjectId) async {
    var homeworksResult = MarksModel();
    var markDoc = await FirebaseFirestore.instance
        .collection('homeworks')
        .where('student_id', isEqualTo: UserInformation.User_uId)
        .where('subject_id', isEqualTo: subjectId)
        .where('session', isEqualTo: 1)
        .get();

    markDoc.docs.forEach((element) {
      homeworksResult.title = 'HomeWorks';
      homeworksResult.mark = element.data()['result'];
      homeworksResult.fmark = element.data()['final_mark'];
    });

    if (homeworksResult != null)
      print(homeworksResult.title);
    else
      print('is fucking null');

    return homeworksResult;
  }

  getExam2Result(String subjectId) async {
    var exam2Result = MarksModel();
    var markDoc = await FirebaseFirestore.instance
        .collection('exam2')
        .where('student_id', isEqualTo: UserInformation.User_uId)
        .where('subject_id', isEqualTo: subjectId)
        .where('session', isEqualTo: 1)
        .get();
    markDoc.docs.forEach((element) {
      exam2Result.title = 'Exam2';
      exam2Result.mark = element.data()['result'];
      exam2Result.fmark = element.data()['final_mark'];
    });

    if (exam2Result != null)
      print(exam2Result.title);
    else
      print('is fucking null');

    return exam2Result;
  }
}
