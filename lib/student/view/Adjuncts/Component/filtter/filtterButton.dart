import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/student/controllers/RefrencesController.dart';
import 'package:school_management_system/student/view/Adjuncts/Component/filtter/filtterComponent/DifficultyFiltter.dart';
import 'package:school_management_system/student/view/Adjuncts/Component/filtter/filtterComponent/gradefiltter.dart';
import 'package:school_management_system/student/view/Adjuncts/Component/filtter/filtterComponent/subjectFiltter.dart';

import '../../../../../public/utils/constant.dart';
import '../../../../../public/utils/font_families.dart';

var _controller = Get.put(RefrencesController());

class FiltterButton extends StatefulWidget {
  const FiltterButton({Key? key}) : super(key: key);

  @override
  State<FiltterButton> createState() => _FiltterButtonState();
}

class _FiltterButtonState extends State<FiltterButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 550.h,
                  child: SingleChildScrollView(
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
                            child: const Text(
                              'Grade',
                              style: TextStyle(
                                color: darkGray,
                                fontFamily: RedHatDisplay.medium,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.w,
                          ),
                          child: ChosingGradeBar(),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 100.w,
                            child: const Text(
                              'Subject',
                              style: TextStyle(
                                color: darkGray,
                                fontFamily: RedHatDisplay.medium,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        ChosingSubjectBar(),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 150.w,
                            child: const Text(
                              'Difficulty',
                              style: TextStyle(
                                color: darkGray,
                                fontFamily: RedHatDisplay.medium,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        ChosingDifficultyBar(),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    ),
                  ),
                ),
                ApplyFiltterButton(
                  Bcontext: context,
                ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Fillter',
            style: TextStyle(
              color: primaryColor,
              fontFamily: RedHatDisplay.medium,
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          const Icon(
            Icons.arrow_drop_down,
            size: 15,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}

class ApplyFiltterButton extends StatelessWidget {
  const ApplyFiltterButton({
    Key? key,
    this.Bcontext,
  }) : super(key: key);

  @override
  final Bcontext;
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(36, 0, 36, 36),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: primaryColor),
          onPressed: () {
            _controller.getFiltredData();
            Navigator.pop(context);
          },
          child: Center(
            child: Text(
              'Apply Filtter',
              style: TextStyle(
                  color: white, fontSize: 20, fontFamily: RedHatDisplay.medium),
            ),
          )),
    );
  }
}
