import 'package:get/get.dart';



import '../controllers/stprofile_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StprofileController>(StprofileController());
  }
}