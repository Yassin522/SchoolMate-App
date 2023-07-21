import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/controllers/subject/subjectController.dart';
import 'package:school_management_system/student/view/Adjuncts/adjuncts.dart';
import 'package:school_management_system/student/view/Home/home_body.dart';
import 'package:school_management_system/student/view/TasksScreen/TasksPage.dart';
import 'package:school_management_system/student/view/TeacherEmails/Teacherspage.dart';

import '../../main.dart';
import '../resources/Parent/parentApi.dart';
import '../resources/Programapi/programsapi.dart';
import '../view/Chat/chats_page.dart';

var _SubjectController = Get.put<SubjectController>(SubjectController());

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var bottomNavgationBarPages = [
    HomeScreen(),
    TasksPage(),
    Refrences(),
    ChatsPage(),
  ].obs;

  var appBarTitles = ['Home', 'Tasks', 'Adjuncts', 'Chat'].obs;
  var myprograms = [].obs;
  var mychilds = [].obs;

  getPrograms() async {
    print('getting programs ...');
    myprograms.value = await ProgramApi.getNewPrograms();
    print(myprograms.value);
    print('Done!');
    update();
  }

  getchilds() async {
    print('getting childs ...');
    print(UserInformation.email);
    mychilds.value = await ParentApi.getStudents(UserInformation.email);
    print(mychilds.value);
    print('Done!');
    update();
  }

  changePages(int index) {
    currentIndex.value = index;
    update();
  }

  showNotification(String filename, String path) {
    flutterLocalNotificationsPlugin.show(
        0,
        filename,
        "The file has been downloaded\n$path",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  showNotification2(String filename, String path) {
    flutterLocalNotificationsPlugin.show(
        0,
        filename,
        path,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  final zoomDrawerController = ZoomDrawerController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _SubjectController.getSujects();
    getPrograms();
    getchilds();
  }
}
