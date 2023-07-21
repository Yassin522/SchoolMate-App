import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_style.dart';
import 'package:school_management_system/student/view/Home/home_appbar.dart';
import 'package:school_management_system/student/view/Home/side_menu.dart';
import 'package:school_management_system/teacher/controllers/home_controller.dart';
import 'package:school_management_system/teacher/view/TAnnouncements/TAnnouncementsScreen.dart';
import 'package:school_management_system/teacher/view/TProfile/TProfileScreen.dart';

var _controller = TeacherHomeController();

class HomeBody extends StatelessWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: SideMenue(
          onPress: () {
            Get.to(
              () => TProfileScreen(),
            );
          },
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: GetBuilder<TeacherHomeController>(
            init: TeacherHomeController(),
            builder: (controller) => CostumHomeAppBar(
                title: controller
                    .appBarTitles.value[controller.currentIndex.value],
                style: redHatRegularStyle(fontSize: 20, color: Colors.white),
                ontap: () {
                  Get.to(() => TAnnouncementsScreen());
                }),
          ),
        ),
        body: GetBuilder<TeacherHomeController>(
          init: TeacherHomeController(),
          builder: (controller) {
            return controller
                .bottomNavgationBarPages.value[controller.currentIndex.value];
          },
        ),
        bottomNavigationBar: GetBuilder(
          init: TeacherHomeController(),
          builder: ((TeacherHomeController controller) => CustomNavigationBar(
                iconSize: 23.0,
                selectedColor: primaryColor,
                strokeColor: Color(0x300c18fb),
                unSelectedColor: Colors.grey[600],
                backgroundColor: Colors.white,
                borderRadius: Radius.circular(10),
                elevation: 8,
                items: [
                  CustomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    title: Text(
                      "Home",
                      style: controller.currentIndex.value == 0
                          ? sfRegularStyle(fontSize: 10, color: primaryColor)
                          : sfRegularStyle(fontSize: 10, color: gray),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: const Icon(
                      Icons.task,
                    ),
                    title: Text(
                      "Tasks",
                      style: controller.currentIndex.value == 1
                          ? sfRegularStyle(fontSize: 10, color: primaryColor)
                          : sfRegularStyle(fontSize: 10, color: gray),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: const Icon(
                      Icons.attachment,
                    ),
                    title: Text(
                      "Adjuncts",
                      style: controller.currentIndex.value == 2
                          ? sfRegularStyle(fontSize: 10, color: primaryColor)
                          : sfRegularStyle(fontSize: 10, color: gray),
                    ),
                  ),
                  CustomNavigationBarItem(
                    icon: const Icon(
                      Icons.message,
                    ),
                    title: Text(
                      "Chats",
                      style: controller.currentIndex.value == 3
                          ? sfRegularStyle(fontSize: 10, color: primaryColor)
                          : sfRegularStyle(fontSize: 10, color: gray),
                    ),
                  ),
                ],
                currentIndex: controller.currentIndex.value,
                onTap: (index) {
                  print(index);
                  controller.changePages(index);
                },
              )),
        ),
      ),
    );
  }
}
