import 'package:get/get.dart';


import '../controllers/RefrencesController.dart';

class RefrencesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RefrencesController>(RefrencesController());
  }
}