import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_system/public/utils/constant.dart';

AppBar CostumAppBar({String? title, TextStyle? style}) {
  return AppBar(
    title: Text('$title', style: style),
    flexibleSpace: Container(
      decoration: BoxDecoration(gradient: gradientColor),
    ),
    actions: [
      Row(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  right: 10.w, top: 10.h, bottom: 26.5.h, left: 15.w),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  size: 32.w,
                  color: Colors.white,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 12.w, top: 10.h, bottom: 26.5.h),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.people_alt,
                  size: 27,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    ],
  );
}
