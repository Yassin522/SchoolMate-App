import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/student/models/Subjects/SubjectsModel.dart';
import 'package:school_management_system/teacher/model/subject/LessonsResponseModels.dart';
import 'package:school_management_system/teacher/view/TSubject/TSubjectsInfo.dart';

class TLessonsServices {
  getLessons(String subjectId) async {
    var lessonsList = [];
    var lessonsnumber = 0;
    var numberOfTakesLessons = 0;
    lessonsList.clear();
    try {
      await FirebaseFirestore.instance
          .collection('lessons')
          .where('subject', isEqualTo: subjectId)
          .get()
          .then((value) {
        lessonsnumber = value.docs.length;
        value.docs.forEach((element) {
          if (element.data()['isTaken'] == true) {
            numberOfTakesLessons++;
          }
          lessonsList.add(lessonModel(
            title: element.data()['name'],
            checked: element.data()['isTaken'],
          ));
        });
      });
      var resulte = LessonsResponseModel(
          lessons: lessonsList,
          numberOflesson: lessonsnumber,
          numberOfTakenLessons: numberOfTakesLessons);
      return resulte;
    } catch (e) {
      return [];
    }
  }

  getLessonsNumber(String subjectId) async {
    var lessonsnumber = 0;

    try {
      await FirebaseFirestore.instance
          .collection('lessons')
          .where('subject', isEqualTo: subjectId)
          .get()
          .then((value) {
        lessonsnumber = value.docs.length;
      });

      return lessonsnumber;
    } catch (e) {
      return 0;
    }
  }

  getTakenLessonsNumber(String subjectId) async {
    var lessonsnumber = 0;

    try {
      await FirebaseFirestore.instance
          .collection('lessons')
          .where('subject', isEqualTo: subjectId)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.data()['isTaken'] == true) {
            lessonsnumber++;
          }
        });
      });

      return lessonsnumber;
    } catch (e) {
      return 0;
    }
  }

  addNewLesson(lessonModel lesson) async {
    var docref = await FirebaseFirestore.instance
        .collection('lessons')
        .doc()
        .id
        .toString();
    print(docref);
    await FirebaseFirestore.instance.collection('lessons').doc(docref).set({
      'name': lesson.title.toString(),
      'isTaken': false,
      'id': docref,
      'subject': lesson.subjectid,
    });
  }

  updateisTakenLesson(bool check, String lessonId) async {
    await FirebaseFirestore.instance
        .collection('lessons')
        .doc(lessonId)
        .update({
      'isTaken': check,
    });
  }
}
