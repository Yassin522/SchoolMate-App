import 'package:flutter/material.dart';
import 'package:school_management_system/public/utils/font_style.dart';

import '../utils/constant.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    required  Function press,

    Key? key,
  }) :_press=press, super(key: key);
   
   final Function _press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> _press.call(),
      child: Container(
      width: MediaQuery.of(context).size.width / 3,
        height: 52,
      child:  Center(
        child:  Text(
        'log in',
            style: sfMediumStyle(fontSize: 24,color: white),
          ),
      ),
    
        decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(
             28.0,
          ),
           gradient:gradientColor
               ),
           ),
    );
  }
}
