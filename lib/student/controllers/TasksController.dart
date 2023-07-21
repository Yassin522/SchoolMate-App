import 'package:get/state_manager.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/models/task/taskMark_model.dart';
import 'package:school_management_system/student/models/task/task_model.dart';
import 'package:path/path.dart';
import 'package:school_management_system/teacher/view/tasks/AddFiles/components/SelectFile.dart';

import '../models/task/task_result_model.dart';
import '../resources/task/task_api.dart';

class TasksController extends GetxController {
  var taskServ = taskServices();
  //var naya = TaskModel().obs;
  //RxList tt = [].obs ;
  var tasks = [].obs;
  var result = TaskMarkModel().obs;
  var file_name = 'Add file'.obs;
  var taskresult;
  var task_name = ''.obs;
  var task_id = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getTask();
  }

  getTask() async {
    tasks.value = await taskServ.getTasks();
  }

  getTaskResult(subjectId, taskid) async {
    print("=====================Result===================");
    result.value = await taskServ.getTestsResult(subjectId, taskid);
    print("---------------------------------------------");
  }

  updateFile(file) {
    if (file == null) return;
    taskresult = file;
    file_name.value = basename(file!.path);
    update();
  }

  uploadTaskResult() async {
    if (taskresult == null) return;
    var url = await uploadfileToFirebase(
      file: taskresult,
      destination:
          '/task results/${UserInformation.grade.toString()}/${task_name.value}/${UserInformation.fullname}',
    );
    print(UserInformation.classid);
    print(UserInformation.User_uId);
    print(url);
    print(task_id.value);
    await taskServ.uploadTaskResult(TaskResultModel(
      classroom_id: UserInformation.classid,
      student_id: UserInformation.User_uId,
      url: url,
      task_id: task_id.value,
    ));
  }
}

/*
  getTask() async {
    await taskServ.getSubjectTask();
    tasks.value = await taskServ.getSubjectTask();
  }


  var question = [].obs;

  getQuestion() async {
    await taskServ.getTaskQuestion();
    question.value = await taskServ.getTaskQuestion();
  }

  var answer = [].obs;

  getAnswer() async {
    await taskServ.getQuestionAnswer();
    answer.value = await taskServ.getQuestionAnswer();
  }
*/