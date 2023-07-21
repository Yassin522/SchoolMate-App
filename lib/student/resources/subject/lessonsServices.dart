import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/student/models/Subjects/SubjectsModel.dart';

class LessonsServices {
  getlessons(String id) async {
    List lessonRefrenceList = [];
    List lessonList = <lessonModel>[];
    lessonList.clear();
    lessonRefrenceList.clear();
    await FirebaseFirestore.instance
        .collection('subject')
        .doc(id)
        .get()
        .then((value) {
      lessonRefrenceList = value.data()?['lessons'];
    });

    for (var i = 0; i < lessonRefrenceList.length; i++) {
      var isTaken;
      var lessonName;
      await FirebaseFirestore.instance
          .doc('/lessons/${lessonRefrenceList[i].id}')
          .get()
          .then((value) {
        isTaken = value.data()?['isTaken'] ?? false;
        lessonName = value.data()!['name'] ?? '00';
      });

      lessonList.add(lessonModel(
        title: lessonName,
        checked: isTaken,
      ));
    }

    return lessonList;
  }

  getTakenLessonNumbe(String id) async {
    int takenLessonNumber = 0;
    List lessonRefrenceList = [];
    lessonRefrenceList.clear();
    await FirebaseFirestore.instance
        .collection('subject')
        .doc(id)
        .get()
        .then((value) {
      lessonRefrenceList = value.data()?['lessons'];
    });
    for (var i = 0; i < lessonRefrenceList.length; i++) {
      var isTaken;
      var lessonName;
      await FirebaseFirestore.instance
          .doc('/lessons/${lessonRefrenceList[i].id}')
          .get()
          .then((value) {
        if (value.data()?['isTaken'] == true) ++takenLessonNumber;
      });
    }
    print('here is the error' + takenLessonNumber.toString());
    return takenLessonNumber;
  }

  getAllLessonNumbe(String id) async {
    int numberOflessons = 0;
    List lessonRefrenceList = [];
    lessonRefrenceList.clear();
    await FirebaseFirestore.instance
        .collection('subject')
        .doc(id)
        .get()
        .then((value) {
      lessonRefrenceList = value.data()?['lessons'];
    });
    numberOflessons = lessonRefrenceList.length;

    return numberOflessons;
  }
}
