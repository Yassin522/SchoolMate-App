import 'package:flutter/material.dart';
import 'package:school_management_system/public/utils/font_style.dart';
import 'package:school_management_system/student/Widgets/animated_progress_indicator.dart';

import '../../public/utils/constant.dart';

class ProgressIndecator extends StatelessWidget {
  ProgressIndecator({
    required double precentage,
    Key? key,
    this.ontap,
    this.isShow,
  })  : _precentage = precentage,
        super(key: key);

  final double _precentage;
  final ontap;
  final isShow;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 20),
      child: Container(
        height: 80,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 50,
              child: AnimatedCircularProgressIndacator(
                percentage: _precentage,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text("Grade Average",
                style: redHatMediumStyle(fontSize: 15, color: primaryColor)),
            const SizedBox(
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                onTap: ontap,
                child: Text("show details",
                    style: redHatRegularStyle(fontSize: 12, color: gray)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: isShow
                  ? Icon(
                      Icons.arrow_drop_up,
                      color: gray,
                    )
                  : Icon(
                      Icons.arrow_drop_down,
                      color: gray,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
