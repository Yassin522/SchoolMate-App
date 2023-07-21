import 'dart:isolate';
import 'dart:ui';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_management_system/routes/app_pages.dart';
import 'package:school_management_system/student/view/Subjects/SubjectsScreen.dart';
import 'package:school_management_system/teacher/controllers/home_controller.dart';
import 'package:school_management_system/teacher/view/TSubject/Subjects/SubjectScreen.dart';
import 'package:school_management_system/teacher/view/TSubject/TSubjectsInfo.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../../public/login/dividerforparent.dart';
import '../../../public/utils/constant.dart';
import '../../../public/utils/font_style.dart';
import '../../../public/utils/util.dart';
import '../../../student/models/programs/programModel.dart';
import '../../../student/view/Home/home.dart';
import '../../../student/view/Home/home_appbar.dart';
import '../../../student/view/Home/side_menu.dart';
import '../../../student/view/Home/subjectCart.dart';

var _controller = Get.put(TeacherHomeController());

class HomeTeacher extends StatelessWidget {
  const HomeTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Home is here");
    print(_controller.currentIndex.value);
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
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
        const SizedBox(
          height: 15,
        ),

       
        FutureBuilder(
            future: _controller.getPrograms(),
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading...'));
              }

              return _controller.myprograms.isEmpty
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
                      itemCount: _controller.myprograms.length,
                      itemBuilder: (BuildContext context, int index) {
                        return programCard(
                          gProgram: _controller.myprograms[index],
                        );
                      },
                    );
            }),
          ),


        
        const DividerParent(
          text: "Classes",
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 210.h,
          width: 540.w,
          child: FutureBuilder(
            future: _controller.getTeacherClasses(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingCircle();
              }
              if (true) {
                if (snapshot.hasError) {
                  return ErrorMessage();
                } /*else if (!snapshot.hasData) {
                  return Center(
                    child: Text('There no classes'),
                  );
                } */
                else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _controller.classesList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TeacherClassesCard(
                        section: _controller.classesList.value[index].section,
                        grade: _controller.classesList.value[index].grade,
                        numberOfStudents: _controller
                            .classesList.value[index].numberOfstudents,
                        classId:
                            _controller.classesList.value[index].classroomID,
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ]),
    );
  }
}

class TeacherClassesCard extends StatelessWidget {
  const TeacherClassesCard({
    this.section,
    this.grade,
    this.numberOfStudents,
    this.classId,
    Key? key,
  }) : super(key: key);

  final section;
  final grade;
  final numberOfStudents;
  final classId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, bottom: 20.h, top: 10.h),
      child: GestureDetector(
        onTap: () {
          print('this is class id ');
          print(classId.toString());
          var data = {
            'grade': grade.toString(),
            'classid': classId.toString(),
          };
          Get.toNamed(AppPages.tsubjects, parameters: data);
        },
        child: Container(
          height: 178.h,
          width: 178.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              gradient: gradientColor),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "$section-$grade",
                      style: sfBoldStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "$numberOfStudents",
                  style: sfBoldStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class programCard extends StatefulWidget {
  programCard({
    required this.gProgram,
  });

  Program gProgram;

  @override
  State<programCard> createState() => _programCardState();
}

 
 void _launchUrl(Uri _url ) async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}

class _programCardState extends State<programCard> {
  DateFormat _dateFormat = DateFormat('y-MM-d');

  ReceivePort _port = ReceivePort();

@override
void initState() {
  super.initState();

  IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
  _port.listen((dynamic data) {
    String id = data[0];
    DownloadTaskStatus status = data[1];
    int progress = data[2];
    setState((){ });
  });

  FlutterDownloader.registerCallback(downloadCallback);
}

@override
void dispose() {
  IsolateNameServer.removePortNameMapping('downloader_send_port');
  super.dispose();
}

@pragma('vm:entry-point')
static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
}

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
              '${widget.gProgram.type}',
              style: sfMediumStyle(fontSize: 16, color: black),
            ),
            Text(
              '${_dateFormat.format(widget.gProgram.date.toDate())}',
              style: sfMediumStyle(fontSize: 10, color: black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      print("downloadddddddd");

                      /*showSnackBar('Starting download...', context);

                      final baseStorage = await getExternalStorageDirectory();
                      final id = await FlutterDownloader.enqueue(
                        url: '${widget.gProgram.url}',
                        savedDir: baseStorage!.path,
                        fileName: 'file name',
                      );*/

                      final Uri _url = Uri.parse(widget.gProgram.url!);

                     _launchUrl(_url);

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
}
