import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/Widgets/custom_appbar.dart';
import 'package:school_management_system/student/view/Home/home_appbar.dart';
import 'package:school_management_system/teacher/controllers/TasksControllers/CheckedStudentTaskInfoController.dart';
import 'package:school_management_system/teacher/controllers/TasksControllers/studentTaskInfo.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';

class StudentsOfTask extends StatelessWidget {
  StudentsOfTask({Key? key, this.taskId, this.taskName}) : super(key: key);
  var uncontroller = Get.find<StudentTaskInfoController>();
  var chcontroller = Get.find<CheckedStudentTaskInfoController>();
  var taskId;
  var taskName;
  @override
  Widget build(BuildContext context) {
    var data = Get.parameters;
    uncontroller.task_id.value = data['id']!;
    chcontroller.task_id.value = data['id']!;
    print(data['id']);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Row(
          children: [
            Text(
              '${data['taskName'].toString()}',
              style: TextStyle(
                color: white,
                fontSize: 24,
                fontFamily: RedHatDisplay.regular,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: gradientColor,
            image: DecorationImage(
              image: AssetImage('assets/images/appbar-background-squares.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Column(children: [
        SizedBox(
          height: 24.h,
        ),
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Fillter',
                style: TextStyle(
                  color: primaryColor,
                  fontFamily: RedHatDisplay.medium,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              const Icon(
                Icons.arrow_drop_down,
                size: 15,
                color: primaryColor,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 370.h,
          width: double.infinity,
          child: FutureBuilder(
            future: uncontroller.getUnCheckedStudentsOftask(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingCircle();
              } else {
                return GetBuilder(
                  init: StudentTaskInfoController(),
                  builder: ((controller) {
                    return ListView.builder(
                      itemCount: uncontroller.studentsTaskList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StudenOfTaskCard(
                          studentName:
                              uncontroller.studentsTaskList.value[index].name,
                          uploadDate: DateFormat("yyyy/MM/dd").format(
                              uncontroller
                                  .studentsTaskList.value[index].uploadeDate),
                          taskId: uncontroller
                              .studentsTaskList.value[index].task_id,
                          taskUrl: uncontroller
                              .studentsTaskList.value[index].taskUrl,
                          photoUrl: uncontroller
                              .studentsTaskList.value[index].photoUrl,
                          index: index,
                          task_result_id:
                              uncontroller.studentsTaskList.value[index].id,
                        );
                      },
                    );
                  }),
                );
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 10.h,
            bottom: 10.h,
          ),
          child: Divider(
            color: gray,
            thickness: 2,
          ),
        ),
        SizedBox(
          height: 340.h,
          width: double.infinity,
          child: FutureBuilder(
            future: chcontroller.getCheckedStudentsOfTask(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingCircle();
              } else {
                return GetBuilder(
                  init: CheckedStudentTaskInfoController(),
                  builder: ((controller) {
                    return ListView.builder(
                      itemCount: chcontroller.studentList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckedStudentsOfTaskCard(
                          name: chcontroller.studentList.value[index].name,
                          uploadeDate: DateFormat("yyyy/MM/dd").format(
                              chcontroller
                                  .studentList.value[index].uploadeDate),
                          mark: chcontroller.studentList.value[index].mark,
                          photoUrl:
                              chcontroller.studentList.value[index].photoUrl,
                          id: chcontroller.studentList.value[index].id,
                          taskUrl:
                              chcontroller.studentList.value[index].taskUrl,
                          task_id:
                              chcontroller.studentList.value[index].task_id,
                          class_id:
                              chcontroller.studentList.value[index].class_id,
                          student_id:
                              chcontroller.studentList.value[index].student_id,
                        );
                      },
                    );
                  }),
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}

class CheckedStudentsOfTaskCard extends StatelessWidget {
  const CheckedStudentsOfTaskCard({
    Key? key,
    this.name,
    this.photoUrl,
    this.uploadeDate,
    this.mark,
    this.id,
    this.taskUrl,
    this.class_id,
    this.student_id,
    this.task_id,
  }) : super(key: key);

  final name;
  final uploadeDate;
  final photoUrl;
  final id;
  final taskUrl;
  final task_id;
  final student_id;
  final class_id;
  final mark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var data = Get.parameters;
        print(taskUrl);

        print(name + ' soultion for ' + data['taskName']);
        await openFile(
            url: taskUrl, fileName: name + ' soultion for ' + data['taskName']);
      },
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
              ),
              child: SizedBox(
                height: 80.h,
                width: double.infinity,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(0),
                                /* actions: [
                              Text('hi'),
                            ],*/
                                content: SizedBox(
                                  height: 300.h,
                                  width: 248.w,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            height: 250.h,
                                            width: 284.w,
                                            child: CircleAvatar(
                                              radius: 80,
                                              backgroundImage: NetworkImage(
                                                  photoUrl.toString()),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 39.h,
                                          color: primaryColor,
                                        ),
                                      ]),
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(photoUrl.toString()),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      SizedBox(
                        height: 70.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100.w,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${name}',
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontFamily: RedHatDisplay.regular,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              width: 100.w,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '$uploadeDate',
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontFamily: RedHatDisplay.medium,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 140.5.h,
                      ),
                      SizedBox(
                        height: 100.h,
                        width: 50.w,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '$mark',
                            style: const TextStyle(
                                color: primaryColor,
                                fontFamily: RedHatDisplay.medium,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          SizedBox(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 50.w, right: 50.w),
                child: const Divider(color: gray),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StudenOfTaskCard extends StatelessWidget {
  StudenOfTaskCard({
    Key? key,
    this.studentName,
    this.uploadDate,
    this.photoUrl,
    this.taskId,
    this.taskUrl,
    this.index,
    this.task_result_id,
  }) : super(key: key);

  final studentName;
  final uploadDate;
  final photoUrl;
  final taskUrl;
  final taskId;
  final index;
  final task_result_id;
  var uncontroller = Get.find<StudentTaskInfoController>();
  @override
  Widget build(BuildContext context) {
    uncontroller.task_id.value = taskId.toString();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          var data = Get.parameters;
          print(taskUrl);

          print(studentName + ' soultion for ' + data['taskName']);
          await openFile(
              url: taskUrl,
              fileName: studentName + ' soultion for ' + data['taskName']);
        },
        child: Container(
          height: 130.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                    ),
                    child: SizedBox(
                      height: 130.h,
                      width: double.infinity,
                      child: Center(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext) {
                                      return AlertDialog(
                                          contentPadding: EdgeInsets.all(0),
                                          /* actions: [
                                      Text('hi'),
                                    ],*/
                                          content: SizedBox(
                                            height: 350.h,
                                            child: Stack(children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  height: 350.h,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                        photoUrl.toString(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  height: 60.h,
                                                  decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ));
                                    },
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(photoUrl.toString()),
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              SizedBox(
                                width: 100.w,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: SizedBox(
                                          child: Text(
                                            '${studentName}',
                                            style: TextStyle(
                                                color: darkGray,
                                                fontFamily:
                                                    RedHatDisplay.regular,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            '$uploadDate',
                                            style: TextStyle(
                                                color: gray,
                                                fontFamily:
                                                    RedHatDisplay.medium,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100.5.h,
                              ),
                              SizedBox(
                                height: 100.h,
                                width: 65.w,
                                child: MaterialButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: 'Add mark for a task',
                                      titleStyle: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontFamily: RedHatDisplay.medium,
                                      ),
                                      confirm: RaisedButton(
                                        onPressed: () async {
                                          print('is pressd');
                                          uncontroller.indexForStd.value =
                                              index;
                                          uncontroller.task_result_id.value =
                                              task_result_id;
                                          EasyLoading.show();
                                          await uncontroller.addMarkForTask();
                                          Get.back();
                                          EasyLoading.showSuccess('Done');
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80.0)),
                                        padding: EdgeInsets.all(0.0),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              gradient: gradientColor,
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 250.0,
                                                minHeight: 50.0),
                                            alignment: Alignment.center,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Add Mark",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                  Icon(Icons.add, color: white),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onConfirm: () {},
                                      content: Column(
                                        children: [
                                          Text(
                                            '${studentName}',
                                            style: TextStyle(
                                              color: black,
                                              fontSize: 15,
                                              fontFamily: RedHatDisplay.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          TextField(
                                            onChanged: (String value) {
                                              uncontroller.newMark.value =
                                                  value;
                                            },
                                            decoration: InputDecoration(
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text('Enter mark'),
                                              ),
                                              labelStyle: TextStyle(
                                                color: primaryColor,
                                                fontSize: 15,
                                              ),
                                              fillColor: backgroundColor,
                                              filled: true,
                                              border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          12.0),
                                                  borderSide: new BorderSide(
                                                      width: 0.0,
                                                      color: backgroundColor)),
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: primaryColor,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
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

Future openFile({required String url, String? fileName}) async {
  final file = await downloadFile(url, fileName!);
  if (file == null) return;
  print('Path: ${file.path}');
  // uncontroller.showNotification(fileName, file.path);
  OpenFile.open(file.path);
}

Future<File?> downloadFile(String url, String name) async {
  final appStorage = await getApplicationDocumentsDirectory();
  final file = File('/${appStorage.path}/$name');
  var dest = '/storage/emulated/0/School mate files/$name';
  try {
    final response = await Dio().download(
      url,
      dest,
      options: Options(
        responseType: ResponseType.plain,
        followRedirects: false,
        receiveTimeout: 0,
      ),
    );

    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    return file;
  } catch (e) {
    print(e);
    return null;
  }
}
