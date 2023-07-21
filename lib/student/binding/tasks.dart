import 'package:get/get.dart';

import '../controllers/TasksController.dart';



class TasksBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TasksController>(TasksController());
  }
}