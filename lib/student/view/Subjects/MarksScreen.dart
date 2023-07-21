import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/controllers/lessonsController.dart';
import 'package:school_management_system/student/controllers/marksController.dart';
import 'package:school_management_system/teacher/view/TSubject/TMarkScreen.dart';

class MarksList extends StatelessWidget {
  const MarksList({Key? key, this.subjectId}) : super(key: key);

  final subjectId;
  @override
  Widget build(BuildContext context) {
    var _controller = Get.put<MarksController>(MarksController());
    _controller.subjectId.value = subjectId;
    return Container(
      width: 428.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
          padding: EdgeInsets.only(left: 45.w),
          child: SizedBox(
            height: 400.h,
            width: 540.w,
            child: Column(
              children: [
                FutureBuilder(
                  future: _controller.getExam1(subjectId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return ShimmerMarksLoading();
                    return Obx((() => MarksListCard(
                          title: _controller.exam1.value.title,
                          mark: _controller.exam1.value.mark,
                          fmark: _controller.exam1.value.fmark,
                        )));
                  },
                ),
                FutureBuilder(
                  future: _controller.getTests(subjectId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return ShimmerMarksLoading();
                    return Obx((() => MarksListCard(
                          title: _controller.tests.value.title,
                          mark: _controller.tests.value.mark,
                          fmark: _controller.tests.value.fmark,
                        )));
                  },
                ),
                FutureBuilder(
                  future: _controller.getHomeworks(subjectId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return ShimmerMarksLoading();
                    return Obx((() => MarksListCard(
                          title: _controller.homeworks.value.title,
                          mark: _controller.homeworks.value.mark,
                          fmark: _controller.homeworks.value.fmark,
                        )));
                  },
                ),
                FutureBuilder(
                  future: _controller.getExam2(subjectId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return ShimmerMarksLoading();
                    return Obx((() => MarksListCard(
                          title: _controller.exam2.value.title,
                          mark: _controller.exam2.value.mark,
                          fmark: _controller.exam2.value.fmark,
                        )));
                  },
                ),
              ],
            ),
          )),
    );
  }
}

class MarksListCard extends StatelessWidget {
  const MarksListCard({
    Key? key,
    this.title,
    this.mark,
    this.fmark,
  }) : super(key: key);

  @override
  final title;
  final mark;
  final fmark;
  Widget build(BuildContext context) {
    return Container(
      width: 428.w,
      height: 56.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 56.h,
                  width: 190.w,
                  child: Center(
                    child: Text(
                      '$title',
                      style: TextStyle(
                        color: darkGray,
                        fontSize: 16,
                        fontFamily: RedHatDisplay.medium,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 56.h,
                  width: 190.w,
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          ' $mark',
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontFamily: RedHatDisplay.medium,
                          ),
                        ),
                        const Text(
                          '/',
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontFamily: RedHatDisplay.medium,
                          ),
                        ),
                        Text(
                          '$fmark',
                          style: const TextStyle(
                            color: black,
                            fontSize: 16,
                            fontFamily: RedHatDisplay.medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
