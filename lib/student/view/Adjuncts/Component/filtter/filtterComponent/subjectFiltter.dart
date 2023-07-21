import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/controllers/RefrencesController.dart';

final _controller = Get.put(RefrencesController());
var subjectList = _controller.subjectsName.value;

class ChosingSubjectBar extends StatelessWidget {
  const ChosingSubjectBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 200.w,
      child: GetBuilder(
        init: RefrencesController(),
        builder: ((controller) => ListView.builder(
              itemCount: subjectList.length,
              itemBuilder: (BuildContext context, int index) {
                return SubjectRadioCard(
                  subjectName: subjectList[index].subjectName,
                  subjectIndex: index + 1,
                );
              },
            )),
      ),
    );
  }
}

class SubjectRadioCard extends StatelessWidget {
  const SubjectRadioCard({
    Key? key,
    this.subjectIndex,
    this.subjectName,
  }) : super(key: key);

  @override
  final subjectIndex;
  final subjectName;

  Widget build(BuildContext context) {
    return RadioListTile<int>(
      value: subjectIndex,
      activeColor: primaryColor,
      title: Text(
        '$subjectName',
        style: TextStyle(
          color: darkGray,
          fontSize: 16,
          fontFamily: RedHatDisplay.medium,
        ),
      ),
      groupValue: _controller.currentSubjectIndex.value,
      onChanged: (int? newindex) {
        _controller.currentSubject.value = subjectName;
        _controller.updateSubjectIndex(newindex!);
      },
    );
  }
}
