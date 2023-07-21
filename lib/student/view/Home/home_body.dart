import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_management_system/student/controllers/home_controller.dart';
import 'package:school_management_system/student/controllers/lessonsController.dart';
import 'package:school_management_system/student/controllers/subject/subjectController.dart';
import 'package:school_management_system/student/models/programs/programModel.dart';
import 'package:school_management_system/student/view/Home/subjectCart.dart';
import 'package:school_management_system/student/view/Subjects/SubjectsScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../public/login/dividerforparent.dart';
import '../../../public/utils/constant.dart';
import '../../../public/utils/font_style.dart';
import '../../../public/utils/util.dart';

var _SubjectController = Get.put<SubjectController>(SubjectController());
var _LessonsController = Get.put<lessonsController>(lessonsController());
var homeController = Get.put<HomeController>(HomeController());

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
            height: 255,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TableCalendar(
                rowHeight: 52,
                firstDay: DateTime.utc(2022, 7, 1),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                shouldFillViewport: true,
                daysOfWeekHeight: 15,
                calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                  weekendTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                  todayTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                  holidayTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                  outsideTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                  disabledTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                  rangeEndTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                  selectedTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                  rangeStartTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                  withinRangeTextStyle: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          FutureBuilder(
            future: homeController.getPrograms(),
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading...'));
              }

              return homeController.myprograms.isEmpty
                  ? SizedBox(
                      height: 25,
                      child: Center(
                        child: Text(
                          'NO Programs',
                        ),
                      ),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                      itemCount: homeController.myprograms.length,
                      itemBuilder: (BuildContext context, int index) {
                        return programCard(
                          gProgram: homeController.myprograms[index],
                        );
                      },
                    );
            }),
          ),
          DividerParent(
            text: "subjects",
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 210.h,
            width: 540.w,
            child: FutureBuilder(
                future: _SubjectController.getSujects(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 20.h, top: 10.h),
                          child: ShimmerSubjectsLoading(),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _SubjectController.subjectList.value.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 20.h, top: 10.h),
                          child: GestureDetector(
                            onTap: () {
                              _LessonsController.getSubjectId(_SubjectController
                                  .subjectList.value[index].id);
                              Get.to(() => SubjectsScreen(
                                    subjectId: _SubjectController
                                        .subjectList.value[index].id,
                                  ));
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                  gradient: gradientColor),
                              child: SubjectDetails(
                                subjectName: _SubjectController
                                    .subjectList.value[index].name,
                                teacherName: _SubjectController
                                    .subjectList.value[index].teacherName,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }
                })),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class ShimmerSubjectsLoading extends StatelessWidget {
  const ShimmerSubjectsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(
                12.0,
              ),
            )),
        baseColor: Colors.grey.shade100,
        highlightColor: loadingPrimarycolor);
  }
}

class programCard extends StatelessWidget {
  programCard({
    required this.gProgram,
  });

  Program gProgram;

  DateFormat _dateFormat = DateFormat('y-MM-d');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25),
      child: Container(
        height: 60,
        width: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            17.0,
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(
                Icons.calendar_month,
                color: primaryColor,
              ),
            ),
            Text(
              '${gProgram.type}',
              style: sfMediumStyle(fontSize: 16, color: black),
            ),
            Text(
              '${_dateFormat.format(gProgram.date.toDate())}',
              style: sfMediumStyle(fontSize: 10, color: black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      print("downloadddddddd");

                      showSnackBar('Starting download...', context);
                      /*openFile(
                        url: '${gProgram.url}',
                        fileName: '${gProgram.type}',
                      );*/
                      /*try{ final taskId = await FlutterDownloader.enqueue(
                        url: '${widget.gProgram.url}',
                        savedDir:
                            '/data/user/0/com.example.school_management_system/files/',
                        showNotification:
                            true, // show download progress in status bar (for Android)
                        openFileFromNotification:
                            true, // click on notification to open downloaded file (for Android)
                      );
                     }catch(e){
                      print(e);
                     }*/

                      final baseStorage = await getExternalStorageDirectory();
                      final id = await FlutterDownloader.enqueue(
                        url: '${gProgram.url}',
                        savedDir: baseStorage!.path,
                        fileName: 'file name',
                      );
                    },
                    child: Icon(
                      Icons.arrow_circle_down,
                      color: gray,
                    ),
                  ),
                  Text(
                    "download",
                    style: sfRegularStyle(fontSize: 10, color: gray),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;
    print('Path: ${file.path}');
    homeController.showNotification(fileName, file.path);
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationSupportDirectory();
    final file = File('${appStorage.path}/$name');

    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }
}
