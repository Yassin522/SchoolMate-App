import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/controllers/lessonsController.dart';
import 'package:school_management_system/teacher/view/TSubject/TlessonScreen.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';

var _controller = Get.put<lessonsController>(lessonsController());

class LessonList extends StatelessWidget {
  const LessonList({
    Key? key,
    this.subjectId,
  }) : super(key: key);

  final subjectId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 635.h,
      width: 428.w,
      child: SizedBox(
        height: 635.h,
        width: 428.w,
        child: FutureBuilder(
            future: _controller.getLessons(subjectId),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return ShimmerLessonsLoading();
                  },
                );
              } else {
                if (snapshot.hasError) {
                  return ErrorMessage();
                } else {
                  return ListView.builder(
                    itemCount: _controller.lessonslist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 400.w,
                        height: 200.h,
                        child: GetBuilder(
                            init: lessonsController(),
                            builder: ((controller) {
                              return LessonCard(
                                title:
                                    _controller.lessonslist.value[index].title,
                                checked: _controller
                                    .lessonslist.value[index].checked,
                                index: index + 1,
                              );
                            })),
                      );
                    },
                  );
                }
              }
            })),
      ),
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
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
