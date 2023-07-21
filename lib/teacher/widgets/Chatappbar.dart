import 'package:flutter/material.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar ChatAppBar() {
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(gradient: gradientColor),
    ),
    actions: [
      Row(
        children: [
          Padding(
              padding: EdgeInsets.only(right: 12.w, top: 10.h, bottom: 26.5.h),
              child: IconButton(
                onPressed: () {
                },
                icon: const Icon(
                  Icons.search,
                  size: 27,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    ],
  );
}
