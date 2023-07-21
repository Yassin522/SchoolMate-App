import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/teacher/Teacher_global_info/Classes_of_Teacher/TeacherClasses.dart';
import 'package:school_management_system/teacher/model/Home/classRoomModel.dart';

class TClassesServices {
  getTeacherClasses() async {
    print('wtf');
    var classesList = [];
    Set<String>? classesListId = {};
    classesList.clear();
    try {
      await FirebaseFirestore.instance
          .collection('relation')
          .where('teacher', isEqualTo: UserInformation.User_uId)
          .get()
          .then((value) {
        for (var element in value.docs) {
          var list = element.data()['classrooms'];
          for (var item in list) {
            classesListId.add(item.toString());
          }
        }
      });
      print('classes is');
      classesListId.forEach((element) {
        print(element);
      });
      for (var item in classesListId) {
        await FirebaseFirestore.instance
            .collection('class-room')
            .doc(item.toString())
            .get()
            .then((value) {
          try {
            var item = ClassRoomModel(
              classroomID: value.data()!['uid'],
              grade: value.data()!['acadimic_year'],
              section: value.data()!['section'],
              numberOfstudents: value.data()!['number_of_students'],
            );
            classesList.add(item);
            TeacherClasses.classesList.add(item);
          } catch (e) {
            print(e);
          }
        });
      }
      return classesList;
    } catch (e) {
      print(e);
      return classesList;
    }
  }
}
