import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/Widgets/animated_progress_indicator.dart';
import 'package:school_management_system/student/Widgets/custom_progress_indecator.dart';
import 'package:school_management_system/teacher/controllers/SubjectController/TMarksController.dart';
import 'package:school_management_system/teacher/view/SProfile/SProfileScreen.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';
import 'package:school_management_system/teacher/widgets/Skilton.dart';
import 'package:shimmer/shimmer.dart';

var _controller = Get.put(TMarksController());
var data = Get.arguments;

class TMarkScreen extends StatelessWidget {
  const TMarkScreen({
    Key? key,
    this.subjectId,
    this.grade,
    this.classId,
  }) : super(key: key);
  final subjectId;
  final grade;
  final classId;
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    print('=======================');

    print(subjectId);
    print(grade);
    print(classId);

    /*print(_controller.subjectId.value = data[0]);
    print(_controller.grade.value = data[1]);
    print(_controller.classid.value = data[2]);*/
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Filtter',
                    style: TextStyle(
                      color: primaryColor,
                      fontFamily: RedHatDisplay.medium,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 500.h,
                  child: GetBuilder(
                      init: TMarksController(),
                      builder: (TMarksController controller) {
                        controller.subjectId.value = subjectId;
                        controller.grade.value = grade;
                        controller.classid.value = classId;
                        return FutureBuilder(
                          future: controller.getMarksForstudentsInSubject(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListView.separated(
                                itemCount: controller.studentsMarks.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(height: 10.h);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return ShimmerMarksLoading();
                                  ;
                                },
                              );
                            } else {
                              if (snapshot.hasError) {
                                return ErrorMessage();
                              } else {
                                return ListView.builder(
                                  itemCount: controller.studentsMarks.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    controller.subjectId.value = subjectId;
                                    controller.grade.value = grade;
                                    controller.classid.value = classId;
                                    return StudentsMarksCard(
                                      name:
                                          controller.studentsMarks[index].name,
                                      mark:
                                          controller.studentsMarks[index].mark,
                                      url: controller.studentsMarks[index].url,
                                      id: controller.studentsMarks[index].stdid,
                                    );
                                  },
                                );
                              }
                            }
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}

class ShimmerMarksLoading extends StatelessWidget {
  const ShimmerMarksLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          width: 404.5.w,
          height: 110.h,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Skilton(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        baseColor: Colors.grey.shade100,
        highlightColor: loadingPrimarycolor);
  }
}

class StudentsMarksCard extends StatelessWidget {
  const StudentsMarksCard({
    Key? key,
    this.mark,
    this.name,
    this.url,
    this.id,
  }) : super(key: key);

  final name;
  final mark;
  final url;
  final id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GestureDetector(
        onTap: () {
          Get.to(SProfileScreen(), arguments: [id]);
        },
        child: Container(
          width: 404.5.w,
          height: 110.h,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              top: 10.h,
              bottom: 10.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(url),
                        child: url == null ? Text('${name[0]}') : null,
                      ),
                      SizedBox(
                        width: 100.w,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '$name',
                            style: TextStyle(
                                color: darkGray,
                                fontSize: 18,
                                fontFamily: RedHatDisplay.medium),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.h,
                  ),
                  child: SizedBox(
                    height: 150.h,
                    width: 50.w,
                    child: AnimatedCircularProgressIndacator(
                      percentage: (mark / 100),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
