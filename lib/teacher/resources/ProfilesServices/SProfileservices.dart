import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/teacher/model/ProfileModels/SProfileInfoModel.dart';
import 'package:school_management_system/teacher/model/subject/TMarksModel.dart';
import 'package:school_management_system/teacher/resources/TsubjectsServices/TMarksServices.dart';
import 'package:school_management_system/teacher/view/SProfile/SProfileScreen.dart';

class SprofileServices {
  getStudentInfo(String id) async {
    var stdinfo = SProfileInfoModel();
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(id.toString())
          .get()
          .then((value) async {
        var classSection = '';
        await FirebaseFirestore.instance
            .collection('class-room')
            .doc(value.data()!['class_id'].toString())
            .get()
            .then((value) {
          classSection = value.data()!['section'];
        });
        stdinfo.fname = value.data()!['first_name'];
        stdinfo.lname = value.data()!['last_name'];
        stdinfo.classroom = classSection;
        stdinfo.url = value.data()!['urlAvatar'];
        stdinfo.avrg = value.data()!['grade_average'];
        stdinfo.phone = value.data()!['phone'];
        stdinfo.paretnPhone = value.data()!['parent_phone'];
        stdinfo.grade = value.data()!['grade'].toString();
        stdinfo.classId = value.data()!['class_id'].toString();
        stdinfo.uid = value.data()!['uid'].toString();
      });

      return stdinfo;
    } catch (e) {
      return SProfileInfoModel();
    }
  }

  getStudentMarks(String grade, String classId, String uid) async {
    var subjectListId = [];
    var subjectMarkLits = [];
    try {
      await FirebaseFirestore.instance
          .collection('relation')
          .where('teacher', isEqualTo: UserInformation.User_uId)
          .where('classrooms', arrayContains: classId.toString())
          .where('grade', isEqualTo: grade)
          .get()
          .then((value) {
        for (var item in value.docs) {
          subjectListId.add(item.data()['subject'].toString());
        }
      });

      var markServices = TMarksServices();
      Set<String> s = {};
      Map<String, String> list = {};
      for (var subjectid in subjectListId) {
        var subjectName = '';
        var subjectId = '';
        await FirebaseFirestore.instance
            .collection('subject')
            .doc(subjectid)
            .get()
            .then((value) {
          subjectName = value.data()!['name'];
          subjectId = value.data()!['id'];
          s.add(subjectId.toString());
          list[subjectId.toString()] = subjectName.toString();
        });
        var test = await markServices.getTestMark(subjectid, grade, uid);
        var homework =
            await markServices.getHomeWorkMark(subjectid, grade, uid);
        var exam1 = await markServices.getExam1kMark(subjectid, grade, uid);
        var exam2 = await markServices.getExam2kMark(subjectid, grade, uid);

        try {
          subjectMarkLits.add(StudentMarkInprofile(
            subjectname: subjectName,
            test: test,
            homework: homework,
            exam1: exam1,
            exam2: exam2,
          ));
          dropController.subjectsDrop.value[subjectName.toString()] =
              subjectId.toString();
          print('Subject name is ');
          print(subjectName.toString());
        } catch (e) {
          continue;
        }
      }

      dropController.subjectNames.clear();
      s.forEach((element) {
        dropController.subjectNames.value.add(list[element]);
      });

      return subjectMarkLits;
    } catch (e) {
      print(e);
      return subjectMarkLits;
    }
  }

  addMark(AddingMarkModel markinfo) async {
    bool isExist = false;
    var docid;
    await FirebaseFirestore.instance
        .collection(markinfo.type.toString())
        .where('grade', isEqualTo: markinfo.grade)
        .where('student_id', isEqualTo: markinfo.uid)
        .where('subject_id', isEqualTo: markinfo.subject)
        .get()
        .then((value) {
      print(value.docs.length);
      if (value.docs.length >= 1) {
        isExist = true;
        docid = value.docs[0].data()['id'].toString();
      }
    });

    if (isExist) {
      await FirebaseFirestore.instance
          .collection(markinfo.type.toString())
          .doc(docid)
          .update({
        'result': markinfo.mark,
        'final_mark': markinfo.fmark,
      });
    } else {
      docid = await FirebaseFirestore.instance
          .collection(markinfo.type.toString())
          .doc()
          .id
          .toString();
      await FirebaseFirestore.instance
          .collection(markinfo.type.toString())
          .doc(docid)
          .set({
        'final_mark': markinfo.fmark,
        'grade': markinfo.grade,
        'result': markinfo.mark,
        'student_id': markinfo.uid,
        'subject_id': markinfo.subject,
        'id': docid,
      });
    }
  }
}
