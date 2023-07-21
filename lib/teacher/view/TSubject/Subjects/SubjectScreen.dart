import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/routes/app_pages.dart';
import 'package:school_management_system/teacher/controllers/SubjectController/TeacherSubjectController.dart';
import 'package:school_management_system/teacher/view/TSubject/TSubjectsInfo.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';
import 'package:school_management_system/teacher/widgets/Skilton.dart';
import 'package:shimmer/shimmer.dart';

var _controller = Get.put<TeacherSubjectController>(TeacherSubjectController());

class SubjectsListScreen extends StatelessWidget {
  const SubjectsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('First is that');
    var data = Get.parameters;
    print(data['grade']);
    print(data['classid']);
    _controller.grade.value = data['grade']!;
    _controller.classId.value = data['classid']!;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Row(
          children: const [
            Text(
              'Subjects',
              style: TextStyle(
                color: white,
                fontSize: 24,
                fontFamily: RedHatDisplay.regular,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          height: 200,
          decoration: const BoxDecoration(
            gradient: gradientColor,
            image: DecorationImage(
              image: AssetImage('assets/images/appbar-background-squares.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 718.h,
            width: double.infinity,
            child: FutureBuilder(
              future: _controller.getTeacherSubject(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerSubjectLoading(); //const LoadingCircle();
                } else {
                  if (snapshot.hasError) {
                    return const ErrorMessage();
                  } else {
                    return GridView.builder(
                        itemCount: _controller.teacherSubjectsList.value.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 24.w,
                            mainAxisSpacing: 24.w),
                        itemBuilder: (context, index) {
                          return TsubjectCard(
                            subjectName: _controller
                                .teacherSubjectsList.value[index].subjectName,
                            subjectId: _controller
                                .teacherSubjectsList.value[index].subjectId,
                            grade: data['grade'].toString(),
                            classId: data['classid'].toString(),
                          );
                        });
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerSubjectLoading extends StatelessWidget {
  const ShimmerSubjectLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: loadingPrimarycolor,
      child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 24.w, mainAxisSpacing: 24.w),
          itemBuilder: (context, index) {
            return Skilton(
              height: 250.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
    );
  }
}

class TsubjectCard extends StatelessWidget {
  const TsubjectCard({
    Key? key,
    this.subjectName,
    this.subjectId,
    this.grade,
    this.classId,
  }) : super(key: key);
  final subjectName;
  final subjectId;
  final grade;
  final classId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('What the hell im sending');
        print(subjectId);
        print(grade);
        print(classId);
        Map<String, String>? data = {
          'subjectId': subjectId,
          'grade': grade.toString(),
          'classId': classId.toString(),
        };
        Get.toNamed(AppPages.tsubjectinfo, parameters: data);
      },
      child: Container(
        height: 250.h,
        width: 200.w,
        decoration: BoxDecoration(
          gradient: gradientColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$subjectName',
              style: const TextStyle(
                  color: white, fontFamily: RedHatDisplay.medium, fontSize: 35),
            ),
          ),
        ),
      ),
    );
  }
}
