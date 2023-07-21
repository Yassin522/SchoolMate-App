import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';

import '../../../../public/utils/font_families.dart';

class AnnouncementsCard extends StatelessWidget {
  const AnnouncementsCard({
    Key? key,
    this.title,
    this.date,
    this.content,
  }) : super(key: key);

  @override
  final title;
  final content;
  final date;
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        showDialog(
          context: context,
          builder: (BuildContext) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
              )
            ],
            scrollable: true,
            title: Text(
              '$title',
              style: TextStyle(
                color: darkGray,
                fontFamily: RedHatDisplay.bold,
                fontSize: 24,
              ),
            ),
            content: Text(
              '$content',
              style: TextStyle(
                color: gray,
                fontFamily: RedHatDisplay.medium,
                fontSize: 16,
              ),
            ),
          ),
        );
      }),
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Container(
          height: 150.h,
          width: 380.w,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: SizedBox(
                        width: 24.w,
                        height: 29.h,
                        child: Icon(
                          Icons.notifications_none_outlined,
                          size: 35,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    SizedBox(
                      height: 80.h,
                      width: 200.w,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '$title',
                                  style: TextStyle(
                                    color: darkGray,
                                    fontSize: 22,
                                    fontFamily: RedHatDisplay.regular,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80.w,
                                height: 30.h,
                                child: Text(
                                  '$content',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: gray,
                                    fontSize: 15,
                                    fontFamily: RedHatDisplay.regular,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100.w,
                  height: 150.h,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 8.w,
                        bottom: 17.h,
                      ),
                      child: Text(
                        '$date',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: gray,
                          fontSize: 12,
                          fontFamily: RedHatDisplay.regular,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
