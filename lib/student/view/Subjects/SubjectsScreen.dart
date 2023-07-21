import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/controllers/lessonsController.dart';
import 'package:school_management_system/student/view/Subjects/LessonsScreen.dart';
import 'package:school_management_system/student/view/Subjects/MarksScreen.dart';

var _controller = Get.put<lessonsController>(lessonsController());
var lessonList = _controller.lessonslist.value;

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({
    Key? key,
    this.subjectId,
  }) : super(key: key);

  final subjectId;
  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Row(
          children: [
            const Text(
              'Subjects',
              style: const TextStyle(
                color: white,
                fontSize: 24,
                fontFamily: RedHatDisplay.regular,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: gradientColor,
            image: DecorationImage(
              image: const AssetImage(
                  'assets/images/appbar-background-squares.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 24.h,
            ),
            Center(
              child: Container(
                height: 50.h,
                width: 320.w,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                    unselectedLabelColor: gray,
                    labelColor: white,
                    indicator: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          height: 50.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: const Text(
                              'Contents',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: RedHatDisplay.medium,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 50.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: const Text(
                              'Marks',
                              style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 12,
                                fontFamily: RedHatDisplay.medium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            SizedBox(
              height: 30.h,
              width: 428.w,
              child: Center(
                child: SizedBox(
                  width: 220.w,
                  height: 35.h,
                  child: Row(
                    children: [
                      FutureBuilder(
                        future:
                            _controller.getTakenLessonNumber(widget.subjectId),
                        builder: ((context, snapshot) => Obx(
                              (() => Text(
                                    '${_controller.numberOftakenLessons.value.toString()}',
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontFamily: RedHatDisplay.medium,
                                    ),
                                  )),
                            )),
                      ),
                      const Text(
                        ' lesson',
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontFamily: RedHatDisplay.medium,
                        ),
                      ),
                      const Text(
                        '\\ ',
                        style: TextStyle(
                          color: black,
                          fontSize: 20,
                          fontFamily: RedHatDisplay.medium,
                        ),
                      ),
                      FutureBuilder(
                        future:
                            _controller.getAllLessonNumber(widget.subjectId),
                        //_controller.getAllLessonNumber(),
                        builder: ((context, snapshot) => Obx((() => Text(
                              '${_controller.numberOfAllLessons.value.toString()}',
                              style: const TextStyle(
                                color: black,
                                fontSize: 20,
                                fontFamily: RedHatDisplay.medium,
                              ),
                            )))),
                      ),
                      const Text(
                        ' lesson',
                        style: TextStyle(
                          color: black,
                          fontSize: 20,
                          fontFamily: RedHatDisplay.medium,
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 83.5.w,
                right: 82.5.w,
              ),
              child: const Divider(
                color: gray,
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            SizedBox(
              height: 639.h,
              width: 428.w,
              child: TabBarView(
                children: [
                  LessonList(subjectId: widget.subjectId),
                  MarksList(subjectId: widget.subjectId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
