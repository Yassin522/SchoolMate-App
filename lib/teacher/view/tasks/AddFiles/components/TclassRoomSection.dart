import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/teacher/controllers/TasksControllers/bottomSheetController.dart';

final _controller =
    Get.put<BottomSheetController>(BottomSheetController(), permanent: true);
var classSection = _controller.classSection.value;

class ChosingClassSection extends StatelessWidget {
  const ChosingClassSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      width: 428.w,
      child: GetBuilder(
        init: BottomSheetController(),
        builder: ((controller) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: classSection.length,
              itemBuilder: (BuildContext context, int index) {
                return ClassRoomSectionOption(
                  section: classSection[index],
                  index: index + 1,
                );
              },
            )),
      ),
    );
  }
}

class ClassRoomSectionOption extends StatelessWidget {
  const ClassRoomSectionOption({
    this.section,
    Key? key,
    this.index,
  }) : super(key: key);

  final section;
  final index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
            width: 25.w,
            child: Radio<int>(
              value: index,
              groupValue: _controller.currentClassSection.value,
              onChanged: (newIndex) {
                _controller.updateClassSectionIndex(newIndex!);
              },
              activeColor: primaryColor,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            height: 25.h,
            width: 25.w,
            child: Center(
              child: Text(
                '$section',
                style: TextStyle(
                  color: gray,
                  fontFamily: RedHatDisplay.medium,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
