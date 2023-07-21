import 'package:flutter/material.dart';
import 'package:school_management_system/public/utils/font_style.dart';

import '../../public/utils/constant.dart';

class AnimatedCircularProgressIndacator extends StatelessWidget {
  const AnimatedCircularProgressIndacator({
    Key? key,
    required this.percentage,
  
  }) : super(key: key);

  final double percentage;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: Duration(seconds: 1),
            builder: (context, double value, child) => Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: value,
                  color: primaryColor,
                  backgroundColor: Colors.white,
                ),
                Center(
                  child: Text(
                    (value * 100).toInt().toString() + "%",
                    style: redHatMediumStyle(fontSize: 12,color: primaryColor),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
      
      ],
    );
  }
}

class AnimatedLinearProgressIndicator extends StatelessWidget {
  const AnimatedLinearProgressIndicator({
    Key? key,
    required this.precentage,
    required this.label,
  }) : super(key: key);

  final double precentage;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20 / 2),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: precentage),
        duration: Duration(seconds: 1),
        builder: (context, double value, child) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: redHatMediumStyle(fontSize: 10,color: primaryColor),
                ),
                Text(
                  (value * 100).toInt().toString() + "%",
                )
              ],
            ),
            SizedBox(height:10),
            LinearProgressIndicator(
              value: value,
              color: primaryColor,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
