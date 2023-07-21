import 'package:get/get.dart';

import '../controllers/SearchController.dart';




class ChatSearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SearchController>(SearchController());
  }
}