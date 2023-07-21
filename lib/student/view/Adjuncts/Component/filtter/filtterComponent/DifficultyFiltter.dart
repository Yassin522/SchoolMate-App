import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/controllers/RefrencesController.dart';

final _controller = Get.put(RefrencesController());
var difficultyList = _controller.difficulty.value;

class ChosingDifficultyBar extends StatelessWidget {
  const ChosingDifficultyBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w),
      child: SizedBox(
        height: 60.h,
        width: 428.w,
        child: GetBuilder(
          init: RefrencesController(),
          builder: ((controller) => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: difficultyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return DifficultyBar(
                    difficulty: difficultyList[index].difficulty,
                    index: index + 1,
                  );
                },
              )),
        ),
      ),
    );
  }
}

class DifficultyBar extends StatelessWidget {
  const DifficultyBar({
    Key? key,
    this.difficulty,
    this.index,
  }) : super(key: key);

  @override
  final difficulty;
  final index;
  Widget build(BuildContext context) {
    return Container(
      height: 30.w,
      width: 100.w,
      child: Row(
        children: [
          SizedBox(
            height: 24.h,
            width: 24.w,
            child: Radio<int>(
              value: index,
              groupValue: _controller.currenDifficulty.value,
              onChanged: (int? newIndex) {
                _controller.updateDifficultyIndex(newIndex!);
                print(_controller.currenDifficulty.value);
              },
              activeColor: primaryColor,
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          SizedBox(
            width: 50.w,
            height: 25.h,
            child: Text(
              '$difficulty',
              style: TextStyle(
                  color: gray, fontSize: 12, fontFamily: RedHatDisplay.medium),
            ),
          )
        ],
      ),
    );
  }
}
