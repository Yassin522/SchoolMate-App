import 'package:get/get.dart';
import 'package:school_management_system/student/resources/task/task_api.dart';
import 'package:school_management_system/teacher/model/Tasks/checkedStudentTaskInfo.dart';

import '../../resources/TaskServices/TaskServices.dart';

class CheckedStudentTaskInfoController extends GetxController {
  var taskServices = TaskServices();
  var studentList = [].obs;

  var task_id = ''.obs;
  getCheckedStudentsOfTask() async {
    print('controller is here ');
    studentList.value =
        await taskServices.getCheckedStudentsOfTask(task_id.value);
  }

  updateList() {
    print(studentList.value);
    studentList.refresh();
    update();
    super.refresh();
  }
}
