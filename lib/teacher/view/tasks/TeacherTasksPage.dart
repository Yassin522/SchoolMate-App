import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/models/TasksInfo.dart';
import 'package:school_management_system/teacher/controllers/RefrencesControllers/TPdfRefrencesController.dart';
import 'package:school_management_system/teacher/controllers/TasksControllers/TeacherTaskController.dart';
import 'package:school_management_system/teacher/controllers/TasksControllers/bottomSheetController.dart';
import 'package:school_management_system/teacher/controllers/home_controller.dart';
import 'package:school_management_system/teacher/view/tasks/AddFiles/components/SelectFile.dart';
import 'package:school_management_system/teacher/view/tasks/AddFiles/components/TclassRoomSection.dart';
import 'package:school_management_system/teacher/view/tasks/AddFiles/components/Tgrade.dart';
import 'package:school_management_system/teacher/view/tasks/TeacherTasksCard.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';
import 'package:school_management_system/teacher/widgets/Skilton.dart';
import 'package:shimmer/shimmer.dart';

var bottomController = Get.put(BottomSheetController());
var taskcontroller = Get.put(TeacherTasksController());

class TeacherTasksPage extends StatelessWidget {
  TeacherTasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Task is here");
    var bottomController = Get.put(BottomSheetController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        drawer: Drawer(),
        /* appBar: CostumAppBar(
          title: 'Tasks',
          style: redHatRegularStyle(fontSize: 24, color: Colors.white),
        ),*/
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              BottomSheetButton(),
              Container(
                height: 718.h,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 24.h,
                    left: 15.w,
                    right: 15.w,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: GetBuilder(
                        init: TeacherTasksController(),
                        builder: (controller) {
                          return FutureBuilder(
                            future: taskcontroller.getTasks(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: SimmerTaskLoading());
                              } else {
                                if (snapshot.hasError) {
                                  return Center(child: ErrorMessage());
                                } else {
                                  return GridView.builder(
                                      dragStartBehavior: DragStartBehavior.down,
                                      itemCount:
                                          taskcontroller.tasksList.value.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 24.w,
                                              mainAxisSpacing: 24.w),
                                      itemBuilder: (BuildContext, index) {
                                        var item = taskcontroller
                                            .tasksList.value[index];
                                        DateTime date = DateTime.parse(item
                                            .uploadDate
                                            .toDate()
                                            .toString());
                                        var uploadeDate =
                                            DateFormat("yyyy/MM/dd")
                                                .format(date);
                                        date = DateTime.parse(
                                            item.deadLine.toDate().toString());
                                        var deadline = DateFormat("yyyy/MM/dd")
                                            .format(date);
                                        return Container(
                                          height: 178.h,
                                          width: 178.w,
                                          decoration: BoxDecoration(
                                            gradient: gradientColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: TeacherTasksCard(
                                            subjectName: item.taskSubjectName,
                                            taskName: item.taskName,
                                            uploadDate: uploadeDate,
                                            deadline: deadline,
                                            bcontext: context,
                                            id: item.taskId,
                                          ),
                                        );
                                      });
                                }
                              }
                            },
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimmerTaskLoadingCard extends StatelessWidget {
  const SimmerTaskLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skilton(
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(20)),
    );
  }
}

class SimmerTaskLoading extends StatelessWidget {
  const SimmerTaskLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: GridView.builder(
            dragStartBehavior: DragStartBehavior.down,
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24.w,
                mainAxisSpacing: 24.w),
            itemBuilder: (BuildContext, index) {
              return SimmerTaskLoadingCard();
            }),
        baseColor: Colors.grey.shade100,
        highlightColor: loadingPrimarycolor);
  }
}

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddFileButton(
      label: 'File',
      onTap: () {
        Get.bottomSheet(
          SizedBox(
            height: Get.size.height * .8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
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
                          child: const ChosingGradeBar(),
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
                            width: 73.w,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: const Text(
                                'Section',
                                style: TextStyle(
                                  color: darkGray,
                                  fontFamily: RedHatDisplay.medium,
                                  fontSize: 20,
                                ),
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
                          child: const ChosingClassSection(),
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
                            width: 73.w,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: const Text(
                                'DeadLine',
                                style: TextStyle(
                                  color: darkGray,
                                  fontFamily: RedHatDisplay.medium,
                                  fontSize: 20,
                                ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetBuilder(
                                  init: BottomSheetController(),
                                  builder: ((controller) {
                                    return Text(
                                      '${bottomController.deadline.value.year}/${bottomController.deadline.value.month}/${bottomController.deadline.value.day}',
                                    );
                                  })),
                              MaterialButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary:
                                                primaryColor, // <-- SEE HERE
                                            onPrimary: white, // <-- SEE HERE
                                            onSurface: black, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary:
                                                  primaryColor, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2030),
                                  ).then((pickedDate) {
                                    // Check if no date is selected
                                    if (pickedDate == null) {
                                      return;
                                    } else {
                                      bottomController
                                          .updateDeadline(pickedDate);
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                  color: gray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 73.w,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: const Text(
                                'File',
                                style: TextStyle(
                                  color: darkGray,
                                  fontFamily: RedHatDisplay.medium,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetBuilder(
                                  init: BottomSheetController(),
                                  builder: (controller) {
                                    return Text(
                                        '${bottomController.fileName.value}');
                                  }),
                              MaterialButton(
                                onPressed: () async {
                                  File file = await selectfile();

                                  bottomController.updateFile(file);
                                },
                                child: Icon(
                                  Icons.attach_file,
                                  size: 20,
                                  color: gray,
                                ),
                              )
                            ],
                          ),
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
                            width: 73.w,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: const Text(
                                'Name',
                                style: TextStyle(
                                  color: darkGray,
                                  fontFamily: RedHatDisplay.medium,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: TextField(
                            onChanged: (String value) {
                              bottomController.taskName.value = value;
                            },
                            decoration: InputDecoration(
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Enter task name'),
                              ),
                              labelStyle: TextStyle(
                                color: primaryColor,
                                fontSize: 15,
                              ),
                              fillColor: backgroundColor,
                              filled: true,
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(12.0),
                                  borderSide: new BorderSide(
                                      width: 0.0, color: backgroundColor)),
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 73.w,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            dropdownColor: backgroundColor,
                            onChanged: (String? newValue) {
                              bottomController.updateSubjectDropmenu(newValue!);
                            },
                            items: List.generate(
                                bottomController.teachersubject.length,
                                (index) {
                              return DropdownMenuItem<String>(
                                  value: bottomController
                                      .teachersubject.value[index]
                                      .toString(),
                                  child: Text(
                                    '${bottomController.teachersubject.value[index]}',
                                  ));
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AddButton(
                    Bcontext: context,
                    onpress: () async {
                      EasyLoading.show();
                      await bottomController.addTask();
                      Get.back();
                      EasyLoading.showSuccess('Done');
                    },
                  ),
                ],
              ),
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
          ignoreSafeArea: true,
        );
      },
    );
  }
}

class AddFileButton extends StatelessWidget {
  const AddFileButton({
    Key? key,
    this.label,
    this.onTap,
  }) : super(key: key);

  final label;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 54.w,
        right: 54.w,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60.h,
          width: 428.w,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add ${label}',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: RedHatDisplay.medium,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Icon(
                    Icons.add,
                    size: 16,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    this.Bcontext,
    this.onpress,
  }) : super(key: key);

  @override
  final Bcontext;
  final onpress;
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(36, 0, 36, 36),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: primaryColor),
          onPressed: onpress,
          child: Center(
            child: Text(
              'ADD',
              style: TextStyle(
                  color: white, fontSize: 20, fontFamily: RedHatDisplay.medium),
            ),
          )),
    );
  }
}
