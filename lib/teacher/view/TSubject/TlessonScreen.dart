// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/controllers/lessonsController.dart';
import 'package:school_management_system/teacher/controllers/SubjectController/lessonsController.dart';
import 'package:school_management_system/teacher/controllers/TasksControllers/bottomSheetController.dart';
import 'package:school_management_system/teacher/view/tasks/TeacherTasksPage.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';
import 'package:school_management_system/teacher/widgets/Skilton.dart';
import 'package:shimmer/shimmer.dart';

var _controller = Get.put(TLessonsController());

class TLessonScreen extends StatelessWidget {
  TLessonScreen({Key? key, this.subjectId}) : super(key: key);

  @override
  var subjectId;

  @override
  Widget build(BuildContext context) {
    print('Hello?');
    var data = Get.parameters;
    print(data);
    print(subjectId);
    // print(data[0].toString());
    _controller.subjectID.value = subjectId.toString();
    print(_controller.subjectID.value);

    return SingleChildScrollView(
      child: Column(
        children: [
          AddFileButton(
            label: 'lesson',
            onTap: () {
              Get.bottomSheet(
                SizedBox(
                  height: 600.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 24.w,
                                top: 24.h,
                              ),
                              child: SizedBox(
                                width: 73.w,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: const Text(
                                    'lesson',
                                    style: TextStyle(
                                      color: darkGray,
                                      fontFamily: RedHatDisplay.medium,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 30.w,
                                right: 30.w,
                              ),
                              child: TextField(
                                onChanged: (String value) {
                                  _controller.addlessoncontroller.value.text =
                                      value;
                                  print(_controller
                                      .addlessoncontroller.value.text);
                                },
                                decoration: InputDecoration(
                                  label: Text('Enter the name of lesson'),
                                ),
                                autofocus: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                      ),
                      Center(child: AddButton(
                        onpress: () {
                          var c = Get.put(BottomSheetController());
                          _controller.addlesson();
                          c.update();
                          Get.back();
                        },
                      )),
                    ],
                  ),
                ),
                backgroundColor: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                isScrollControlled: true,
              );
            },
          ),
          SizedBox(
            height: 24.h,
          ),
          SizedBox(
            height: 635.h,
            width: 428.w,
            child: GetBuilder(
              init: BottomSheetController(),
              builder: ((controller) {
                return FutureBuilder(
                  future: _controller.getLessonnForSubject(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ShimmerLessonsLoading();
                    } else {
                      if (snapshot.hasError) {
                        return const ErrorMessage();
                      } else if (_controller.lessonslist.isEmpty) {
                        return const Center(
                            child: Text('There is no lessons.'));
                      } else {
                        return ListView.builder(
                          itemCount: _controller.lessonslist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  width: 400.w,
                                  height: 100.h,
                                  child: GetBuilder(
                                      init: TLessonsController(),
                                      builder:
                                          ((TLessonsController controller) {
                                        return LessonCard(
                                          title: _controller
                                              .lessonslist.value[index].title,
                                          checked: _controller
                                              .lessonslist.value[index].checked,
                                          index: index + 1,
                                        );
                                      })),
                                ),
                                SizedBox(
                                  height: 60.h,
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerLessonsLoading extends StatelessWidget {
  const ShimmerLessonsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: ListView.builder(
        itemCount: 11,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 400.w,
            height: 200.h,
            child: Skilton(
              width: 200.w,
              height: 100.h,
              decoration: const BoxDecoration(color: white),
            ),
          );
        },
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: loadingPrimarycolor,
    );
  }
}

class LessonCard extends StatelessWidget {
  const LessonCard({
    Key? key,
    this.title,
    this.index,
    this.checked,
  }) : super(key: key);

  @override
  final title;
  final index;
  final checked;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20.h,
      ),
      child: CheckboxListTile(
        checkColor: white,
        activeColor: primaryColor,
        title: SizedBox(
          width: 200.w,
          height: 100.h,
          child: Row(
            children: [
              Text(
                '$index',
                style: TextStyle(
                  color: darkGray,
                  fontSize: 20.h,
                  fontFamily: RedHatDisplay.medium,
                ),
              ),
              Text(
                ' - ',
                style: TextStyle(
                  color: darkGray,
                  fontSize: 20.h,
                  fontFamily: RedHatDisplay.medium,
                ),
              ),
              Text(
                '$title',
                style: TextStyle(
                  color: darkGray,
                  fontSize: 20.h,
                  fontFamily: RedHatDisplay.medium,
                ),
              ),
            ],
          ),
        ),
        value: checked,
        onChanged: (bool? value) {
          _controller.updateCheckBox(index);
        },
      ),
    );
  }
}
