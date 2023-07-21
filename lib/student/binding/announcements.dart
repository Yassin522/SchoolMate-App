import 'package:get/get.dart';

import '../controllers/AnnouncementsController.dart';




class AnnouncementsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AnnouncementsController>(AnnouncementsController());
  }
}