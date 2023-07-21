import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/view/Announcements/announcementsCard.dart';
import 'package:school_management_system/teacher/controllers/AnnouncementsController/AnnouncementsController.dart';

var _controller = Get.put<TAnnouncementsController>(TAnnouncementsController());

class TAnnouncementsScreen extends StatelessWidget {
  const TAnnouncementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              image: AssetImage('assets/images/appbar-background-squares.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
                height: 770.h,
                width: 428.w,
                child: SizedBox(
                  child: GetBuilder(
                      init: TAnnouncementsController(),
                      builder: (controller) {
                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('announcement')
                              .where('type',
                                  whereIn: ['Teachers', 'All']).snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: const Text('Laoding...'),
                              );
                            } else {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                              } else {
                                return const Center(
                                  child: Text('Nothing to show'),
                                );
                              }
                            }
                          },
                        );
                      }),
                )),
          ),
        ],
      )),
    );
  }
}
