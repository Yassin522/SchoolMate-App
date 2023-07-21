import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/controllers/AnnouncementsController.dart';
import 'package:school_management_system/student/resources/AnnouncementsServeces/AnnouncementsServeces.dart';
import 'package:school_management_system/student/view/Announcements/announcementsCard.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';

var _controller = Get.put<AnnouncementsController>(AnnouncementsController());
var announcementsList = _controller.announcementsList.value;
AnnouncementsServeces _annServices = AnnouncementsServeces();
String userIdclassroom = '';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    getuserId();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Row(
            children: [
              const Text(
                'Announcements',
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
                image:
                    AssetImage('assets/images/appbar-background-squares.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  height: 770.h,
                  width: 428.w,
                  child: GetBuilder(
                    init: AnnouncementsController(),
                    builder: (controller) {
                      print('Helllllo');
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('announcement')
                              .where('class-room',
                                  isEqualTo: userIdclassroom.toString())
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: const Text('Laoding...'),
                              );
                            } else {
                              if (snapshot.hasError) {
                                return ErrorMessage();
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print('UserId');
                                    print(userIdclassroom);

                                    print(snapshot.data!.docs[index]['date']
                                        .toDate()
                                        .toString());
                                    final DateTime docDateTime = DateTime.parse(
                                        snapshot.data!.docs[index]['date']
                                            .toDate()
                                            .toString());
                                    var annoDate = DateFormat("yyyy/MM/dd")
                                        .format(docDateTime);

                                    return AnnouncementsCard(
                                      title: snapshot.data!.docs[index]
                                          ['title'],
                                      content: snapshot.data!.docs[index]
                                          ['content'],
                                      date: annoDate,
                                    );
                                  },
                                );
                              }
                            }
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

getuserId() async {
  userIdclassroom = await _annServices.getUserClassroom();
}
