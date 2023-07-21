import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:school_management_system/teacher/controllers/TasksControllers/CheckedStudentTaskInfoController.dart';
import 'package:school_management_system/teacher/model/Tasks/studentTaskInfo.dart';
import 'package:school_management_system/teacher/resources/TaskServices/TaskServices.dart';
import 'package:school_management_system/teacher/view/tasks/studentsOfTask.dart';

import '../../../main.dart';
import '../../model/Tasks/checkedStudentTaskInfo.dart';

class StudentTaskInfoController extends GetxController {
  var taskServices = TaskServices();
  var studentsTaskList = [
    /*StudentTaskInfoModel(name: 'Kok', uploadeDate: '2022/8/6'),
    StudentTaskInfoModel(name: 'Rissoto', uploadeDate: '2022/7/4'),
    StudentTaskInfoModel(name: 'Jojo', uploadeDate: '2022/12/4'),*/
  ].obs;

  var task_id = ''.obs;
  var newMark = ''.obs;
  var indexForStd = 0.obs;
  var task_result_id = ''.obs;
  getUnCheckedStudentsOftask() async {
    print('task id is: ${task_id.value.toString()}');
    studentsTaskList.value =
        await taskServices.getUnCheckedStudentsOfTask(task_id.value.toString());
  }

  addMarkForTask() async {
    //
    print('************************');
    print(newMark.value);
    print(indexForStd.value);
    print(task_result_id.value.toString());
    await taskServices.addMarkForTask(task_result_id.value, newMark.value);
    StudentTaskInfoModel oldItem = studentsTaskList.value[indexForStd.value];
    var item = CheckedStudentTaskInfo(
      name: oldItem.name,
      photoUrl: oldItem.photoUrl,
      uploadeDate: oldItem.uploadeDate,
      mark: int.parse(newMark.value),
      id: oldItem.id,
      taskUrl: oldItem.taskUrl,
      class_id: oldItem.class_id,
      student_id: oldItem.student_id,
      task_id: oldItem.task_id,
    );
    var chcontroller = Get.find<CheckedStudentTaskInfoController>();
    chcontroller.studentList.value.add(item);
    studentsTaskList.value.removeAt(indexForStd.value);
    studentsTaskList.refresh();
    chcontroller.studentList.refresh();
    update();
    chcontroller.updateList();
    super.refresh();
  }

  showNotification(String filename, String path) {
    flutterLocalNotificationsPlugin.show(
        0,
        filename,
        "The file has been downloaded\n$path",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }
}
