import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/teacher/model/subject/TMarksModel.dart';

class TMarksServices {
  getAllMarks(String subjectId, String grade, String classid) async {
    List<TMarksStudentModel> studentMarkList = [];
    print(subjectId);
    print(grade);
    print(classid);

    try {
      List<dynamic> studentsList = await getStudentsId(classid);
      print('students');
      print(studentsList);
      for (var i = 0; i < studentsList.length; i++) {
        var testMark = await getTestMark(subjectId, grade, studentsList[i].id);
        print(testMark);
        var homeworkMark =
            await getHomeWorkMark(subjectId, grade, studentsList[i].id);
        var exam1Mark =
            await getExam1kMark(subjectId, grade, studentsList[i].id);
        var exam2Mark =
            await getExam2kMark(subjectId, grade, studentsList[i].id);

        var finalMark = (testMark + homeworkMark + exam1Mark + exam2Mark) == 0
            ? 0
            : (testMark + homeworkMark + exam1Mark + exam2Mark) / 4;
        studentMarkList.add(TMarksStudentModel(
          mark: finalMark,
          name: studentsList[i].fname + ' ' + studentsList[i].lname,
          url: studentsList[i].photoUrl,
          stdid: studentsList[i].id.toString(),
        ));
      }
      print('#######################');
      print(studentMarkList);
      return studentMarkList;
    } catch (e) {
      print('Error hapen');
      return [];
    }
  }

  getTestMark(String subjectId, String grade, String uid) async {
    var testMark = 0;
    try {
      await FirebaseFirestore.instance
          .collection('tests')
          .where('subject_id', isEqualTo: subjectId)
          .where(
            'grade',
            isEqualTo: grade.toString(),
          )
          .where('student_id', isEqualTo: uid.toString())
          .get()
          .then((value) {
        testMark = value.docs[0].data()['result'];
      });

      return testMark;
    } catch (e) {
      return 0;
    }
  }

  getHomeWorkMark(String subjectId, String grade, String uid) async {
    var testMark = 0;
    try {
      print('HomeWork start');
      print(subjectId);
      print(grade);
      print(uid);
      await FirebaseFirestore.instance
          .collection('homeworks')
          .where('subject_id', isEqualTo: subjectId)
          .where(
            'grade',
            isEqualTo: grade.toString(),
          )
          .where('student_id', isEqualTo: uid.toString())
          .get()
          .then((value) {
        testMark = value.docs[0].data()['result'];
        print(testMark);
      });

      return testMark;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  getExam1kMark(String subjectId, String grade, String uid) async {
    var testMark = 0;
    try {
      await FirebaseFirestore.instance
          .collection('exam1')
          .where('subject_id', isEqualTo: subjectId)
          .where(
            'grade',
            isEqualTo: grade.toString(),
          )
          .where('student_id', isEqualTo: uid.toString())
          .get()
          .then((value) {
        testMark = value.docs[0].data()['result'];
      });

      return testMark;
    } catch (e) {
      return 0;
    }
  }

  getExam2kMark(String subjectId, String grade, String uid) async {
    var testMark = 0;
    try {
      await FirebaseFirestore.instance
          .collection('exam2')
          .where('subject_id', isEqualTo: subjectId)
          .where(
            'grade',
            isEqualTo: grade.toString(),
          )
          .where('student_id', isEqualTo: uid.toString())
          .get()
          .then((value) {
        testMark = value.docs[0].data()['result'];
      });

      return testMark;
    } catch (e) {
      return 0;
    }
  }

  getStudentsId(String classid) async {
    var studentsList = [];
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .where('class_id', isEqualTo: classid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          studentsList.add(StundentMarksModel(
            fname: element.data()['first_name'],
            lname: element.data()['last_name'],
            id: element.data()['uid'],
            photoUrl: element.data()['urlAvatar'],
          ));
        });
      });

      return studentsList;
    } catch (e) {
      return [];
    }
  }
}
