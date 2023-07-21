

import 'package:flutter/material.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_style.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({
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
          padding: const EdgeInsets.only(top: 20),
          child: Row(
             children:  <Widget> [
                  const Icon(
                      Icons.menu,
                      color: Colors.white,
                   ),
                  const SizedBox(
                      width: 24,
                   ),
                   Text(
                     "Home",
                       style: redHatRegularStyle(fontSize: 20,color: Colors.white)
                   ),
                    const SizedBox(
                      width: 160,
                   ),
                    const Icon(
                      Icons.notifications,
                      color: Colors.white,
                   ),
                    const SizedBox(
                      width: 20,
                   ),

                   const Icon(
                      Icons.people,
                      color: Colors.white,
                   ),
             ],
          ),
        ),
      ),
           );
  }
}

