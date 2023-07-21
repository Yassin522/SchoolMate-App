import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../../public/config/user_information.dart';
import 'package:school_management_system/student/models/task/task_model.dart';
import '../../models/task/taskMark_model.dart';
import '../../models/task/task_result_model.dart';

class taskServices {
  getTasks() async {
    print('=============Classroom is :==============');
    print(UserInformation.classroom);

    await FirebaseFirestore.instance
        .doc('/students/${UserInformation.User_uId}')
        .get()
        .then((value) {
      UserInformation.classroom = value.data()!['class'].id;
    });
    print(UserInformation.classroom);
    var tasks = [];

    var taskList = await FirebaseFirestore.instance
        .collection('Task')
        .where('classroom', isEqualTo: UserInformation.classroom)
        .orderBy('uploadDate')
        .get();

    for (var i = 0; i < taskList.docs.length; i++) {
      var docUpliadeTime = DateTime.parse(
          taskList.docs[i].data()['uploadDate'].toDate().toString());
      var uploadedate = DateFormat("yyyy/MM/dd").format(docUpliadeTime);

      var docDeadlineTime = DateTime.parse(
          taskList.docs[i].data()['deadline'].toDate().toString());
      var deadline = DateFormat("yyyy/MM/dd").format(docDeadlineTime);

      if (DateTime.now().isAfter(docDeadlineTime)) {
        continue;
      } else {
        tasks.add(TaskModel(
          name: taskList.docs[i].data()['name'],
          subjectName: taskList.docs[i].data()['subjectName'],
          deadline: deadline,
          uploadDate: uploadedate,
          id: taskList.docs[i].data()['id'].toString(),
        ));
      }
    }
    return tasks;
  }

  getTestsResult(String subjectId, String taskid) async {
    var testResult = TaskMarkModel();
    var markDoc = await FirebaseFirestore.instance
        .collection('tests')
        .where('student_id', isEqualTo: UserInformation.User_uId)
        .where('subject_id', isEqualTo: subjectId)
        .where('taskid', isEqualTo: taskid)
        .get();
    markDoc.docs.forEach((element) {
      testResult.StudenUploadDate = element.data()['StudenUploadDate'];
      testResult.mark = element.data()['result'];
    });

    if (testResult != null)
      print(testResult.mark);
    else
      print('is fucking null');

    return testResult;
  }

  uploadTaskResult(TaskResultModel item) async {
    try {
      var id =
          await FirebaseFirestore.instance.collection('Task-result').doc().id;
      FirebaseFirestore.instance
          .collection('Task-result')
          .doc(id.toString())
          .set({
        'checked': false,
        'classroom_id': item.classroom_id,
        'mark': 0,
        'student_id': item.student_id,
        'task_id': item.task_id,
        'task_result_id': id,
        'uploadDate': Timestamp.fromDate(DateTime.now()),
        'url': item.url,
      }, SetOptions(merge: true));
    } catch (e) {
      print('@#@#@#@#@#');
    }
  }
}
