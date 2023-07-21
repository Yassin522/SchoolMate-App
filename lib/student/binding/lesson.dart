import 'package:get/get.dart';


import '../controllers/lessonsController.dart';

class LessonsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<lessonsController>(lessonsController());
  }
}