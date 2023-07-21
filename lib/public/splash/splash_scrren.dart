import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/splash/splash_controller.dart';

class Splash extends StatelessWidget {
   Splash({Key? key}) : super(key: key);

  SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset('assets/images/teacher.png'),
        ),
      ),
    );
  }
}
