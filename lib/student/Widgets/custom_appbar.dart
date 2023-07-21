

import 'package:flutter/material.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_style.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     height: 75,
     width: 413,
      decoration: const BoxDecoration(
       gradient: gradientColor,
       image:  DecorationImage(image: AssetImage('assets/images/appbar-background-squares.png'),alignment: Alignment.bottomCenter),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
             children:  <Widget> [
                  const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                   ),
                  const SizedBox(
                      width: 10,
                   ),
                   Text(
                     "Profile",
                       style: redHatRegularStyle(fontSize: 20,color: Colors.white)
                   ),
             ],
          ),
        ),
      ),
           );
  }
}

