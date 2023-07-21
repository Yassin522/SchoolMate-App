




import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../config/user_information.dart';

class SplashController extends GetxController {
  late GetStorage _storage;
  @override
  void onInit() async {
    _storage = GetStorage();
    await CheckID();
    super.onInit();
  }

  Future<void> CheckID() async {
    String? Uid = await _storage.read('uid');
    print(Uid);
    if (Uid != null) {
      UserInformation.User_uId = Uid;
      
      Get.offAllNamed('/sthome');
      print(Uid);
    } else {
      Get.offNamed('/login');
    }
  }
}