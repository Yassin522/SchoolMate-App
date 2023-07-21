import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/models/task/task_model.dart';
import 'package:school_management_system/student/view/Adjuncts/refrences.dart';
import 'package:school_management_system/teacher/model/Tasks/tasksModel.dart';
import 'package:school_management_system/teacher/view/tasks/AddFiles/components/Tgrade.dart';

import '../../model/Tasks/checkedStudentTaskInfo.dart';
import '../../model/Tasks/studentTaskInfo.dart';

class TaskServices {
  getteacherTasks() async {
    var tasksList = [];
    tasksList.clear();
    try {
      await FirebaseFirestore.instance
          .collection('Task')
          .where('teacher_id', isEqualTo: UserInformation.User_uId)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          TeacherTasksModel item = TeacherTasksModel();
          item.taskClassroomId = element.data()['classroom'];
          item.taskId = element.data()['id'];
          item.deadLine = element.data()['deadline'];
          item.taskName = element.data()['name'];
          item.taskSubjectName = element.data()['subjectName'];
          item.uploadDate = element.data()['uploadDate'];
          item.url = element.data()['url'];
          item.subjectId = element.data()['subject_id'];
          try {
            tasksList.add(item);
          } catch (e) {
            print("#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#");
            print(e);
          }
        });
      });
      return tasksList;
    } catch (e) {
      return tasksList;
    }
  }

  getTeachergardes() async {
    Set<String> s = {};

    try {
      await FirebaseFirestore.instance
          .collection('relation')
          .where('teacher', isEqualTo: UserInformation.User_uId)
          .get()
          .then((value) {
        for (var item in value.docs) {
          s.add(item.data()['grade']);
        }
      });
      var _gardeslist = [];
      s.forEach((element) {
        _gardeslist.add(element);
      });
      return _gardeslist;
    } catch (e) {
      print('@#@#@#@#@#@#@#@#@#@#@#@#@#@#');
    }
  }

  deleteTask(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('Task')
          .doc(id.toString())
          .delete();
    } catch (e) {
      print('@#@#@#@#@#@#@#');
      print('delte faild');
    }
  }

  getTeacherSubject(List grades) async {
    var _subject = [];
    await FirebaseFirestore.instance
        .collection('relation')
        .where('grade', whereIn: grades)
        .where('teacher', isEqualTo: UserInformation.User_uId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _subject.add(element.data()['subject_name']);
      });
    });
    return _subject;
  }

  addTask(UploadTaskModel task) async {
    print('Adding start');
    String tname = UserInformation.first_name + ' ' + UserInformation.last_name;
    var url = await uploadFile(task.file, tname, task.name, task.grade);
    var docid = await FirebaseFirestore.instance.collection('Task').doc().id;
    var classid = '';
    await FirebaseFirestore.instance
        .collection('class-room')
        .where(
          'acadimic_year',
          isEqualTo: task.grade.toString(),
        )
        .where('section', isEqualTo: task.classId.toString())
        .get()
        .then((value) {
      classid = value.docs[0].data()['uid'];
    });
    await FirebaseFirestore.instance
        .collection('Task')
        .doc(docid.toString())
        .set({
      'classroom': classid.toString(),
      'deadline': task.deadLine,
      'id': docid,
      'name': task.name,
      'subjectName': task.subjectName,
      'teacher_id': UserInformation.User_uId,
      'uploadDate': Timestamp.fromDate(DateTime.now()),
      'url': url.toString(),
    });

    print('Its Done!!!');
  }

  static Future uploadFile(
      File file, String tname, String taskname, String grade) async {
    print('upload start');
    print(tname);
    if (file == null) return;
    //gs://school-management-system-6b1c2.appspot.com/tasks/2/Ahmad Teacher

    final destination = '/tasks/$grade/$tname/$taskname';
    print(destination);
    var task = await FirebaseStorage.instance.ref(destination);
    print('taskref  start');
    await task.putFile(file);
    print('file uploaded');
    var urlDownload = await task.getDownloadURL();
    print('3aaaaaaaaaaaaaaaaaa');
    print('Download-link : $urlDownload');

    return urlDownload;
  }

  ////////////////////////students////////////////
  getUnCheckedStudentsOfTask(String taskId) async {
    var taskresult = [];
    try {
      await FirebaseFirestore.instance
          .collection('Task-result')
          .where('task_id', isEqualTo: taskId)
          .where('checked', isEqualTo: false)
          .get()
          .then((value) async {
        for (var item in value.docs) {
          var name, photoUrl;
          await FirebaseFirestore.instance
              .collection('students')
              .doc(item.data()['student_id'].toString())
              .get()
              .then((value) {
            name =
                value.data()!['first_name'] + ' ' + value.data()!['last_name'];
            photoUrl = value.data()!['urlAvatar'];
          });
          var dateStamp =
              DateTime.parse(item.data()['uploadDate'].toDate().toString());

          try {
            StudentTaskInfoModel result = StudentTaskInfoModel(
              id: item.data()['task_result_id'],
              name: name,
              photoUrl: photoUrl,
              uploadeDate: dateStamp,
              taskUrl: item.data()['url'],
              task_id: item.data()['task_id'],
              student_id: item.data()['student_id'],
              class_id: item.data()['class_id'],
            );
            taskresult.add(result);
          } catch (e) {
            print("@#@#@#@#@#@#@#@#@#@#@#@#");
            print(e);
          }
        }
      });
      return taskresult;
    } catch (e) {
      return taskresult;
    }
  }

  getCheckedStudentsOfTask(String taskId) async {
    var taskresult = [];
    try {
      await FirebaseFirestore.instance
          .collection('Task-result')
          .where('task_id', isEqualTo: taskId)
          .where('checked', isEqualTo: true)
          .get()
          .then((value) async {
        for (var item in value.docs) {
          var name, photoUrl;
          await FirebaseFirestore.instance
              .collection('students')
              .doc(item.data()['student_id'].toString())
              .get()
              .then((value) {
            name =
                value.data()!['first_name'] + ' ' + value.data()!['last_name'];
            photoUrl = value.data()!['urlAvatar'];
          });
          var dateStamp =
              DateTime.parse(item.data()['uploadDate'].toDate().toString());

          try {
            CheckedStudentTaskInfo result = CheckedStudentTaskInfo(
                id: item.data()['task_result_id'],
                name: name,
                photoUrl: photoUrl,
                uploadeDate: dateStamp,
                mark: item.data()['mark'],
                taskUrl: item.data()['url']);
            taskresult.add(result);
          } catch (e) {
            print("@#@#@#@#@#@#@#@#@#@#@#@#");
            print(e);
          }
        }
      });
      print('The List is here');
      print(taskresult);
      return taskresult;
    } catch (e) {
      print("@#@#@#@#@#@#@#@#@#@#@#@#");
      print(e);
      return taskresult;
    }
  }

  addMarkForTask(String id, String mark) async {
    await FirebaseFirestore.instance.collection('Task-result').doc(id).update({
      'checked': true,
      'mark': int.parse(mark),
    });
  }
}
