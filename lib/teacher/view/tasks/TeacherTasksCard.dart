import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/public/utils/font_style.dart';
import 'package:school_management_system/routes/app_pages.dart';
import 'package:school_management_system/teacher/view/tasks/TeacherTasksPage.dart';
import 'package:school_management_system/teacher/view/tasks/studentsOfTask.dart';

class TeacherTasksCard extends StatelessWidget {
  const TeacherTasksCard({
    Key? key,
    required this.subjectName,
    required this.taskName,
    required this.uploadDate,
    required this.deadline,
    this.id,
    this.bcontext,
  }) : super(key: key);

  final subjectName;
  final taskName;
  final uploadDate;
  final deadline;
  final id;
  final bcontext;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppPages.studentsOfTask, parameters: {
          'id': id,
          'taskName': taskName,
        });
      },
      child: Container(
        width: 200.w,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.w,
                  top: 24.h,
                  bottom: 2.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${subjectName}',
                          style: redHatBoldStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('$taskName',
                          textAlign: TextAlign.start,
                          style: redHatLightStyle(
                            fontSize: 12,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 15.w,
                  top: 15.h,
                ),
                child: SizedBox(
                  height: 30.h,
                  child: DropdownButton(
                    underline: Text(''),
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(
                      Icons.menu,
                      size: 19,
                      color: Colors.white,
                    ),
                    items: [
                      DropdownMenuItem(
                        onTap: () async {
                          await Get.dialog(Container(
                            color: Colors.greenAccent,
                          ));
                          print('is Open');
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Delete task"),
                                content: Text(
                                    "Are you sure you want to delete the task?"),
                                actions: [
                                  FlatButton(
                                    child: Text(
                                      "Dismiss",
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 16,
                                        fontFamily: RedHatDisplay.medium,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    color: Colors.redAccent,
                                    child: Text("Confirm",
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 18,
                                          fontFamily: RedHatDisplay.medium,
                                        )),
                                    onPressed: () async {
                                      EasyLoading.show();
                                      await taskcontroller.deleteTask(id);
                                      Navigator.of(context).pop();

                                      EasyLoading.showSuccess('Done');
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          Navigator.pop(context);
                        },
                        value: 'Delete',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delete'),
                            SizedBox(
                              width: 4.w,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 95.w,
                  top: 124.h,
                  right: 10.w,
                  bottom: 16.h,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 35.h),
                    child: Column(
                      children: [
                        Container(
                          width: 70.w,
                          height: 13.h,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_drop_up,
                                size: 15.h,
                                color: Colors.white,
                              ),
                              Text(
                                '$uploadDate',
                                style: redHatRegularStyle(
                                  fontSize: 12.h,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          width: 70.w,
                          height: 13.h,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_drop_down,
                                size: 15.h,
                                color: Colors.white,
                              ),
                              Text(
                                '$deadline',
                                style: redHatRegularStyle(
                                  fontSize: 12.h,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
