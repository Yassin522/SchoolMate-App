import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/student/Widgets/CustomAppBar.dart';
import 'package:school_management_system/student/Widgets/custom_progress_indecator.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';
import '../../../public/utils/font_families.dart';
import '../../../public/utils/font_style.dart';
import 'dart:typed_data';
import '../../../teacher/view/SProfile/SProfileScreen.dart';
import '../../Widgets/global_info.dart';
import '../../controllers/stprofile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentProfile extends StatelessWidget {
  final StprofileController c = Get.put(StprofileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CostumAppBar(title: "Profile"),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.h,
              ),
              GetBuilder<StprofileController>(
                init: StprofileController(), // INIT IT ONLY THE FIRST TIME
                builder: (_) => Stack(
                  children: [
                    Container(
                      height: 135,
                      width: 135,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                        image: DecorationImage(
                          image: UserInformation.urlAvatr != null
                              ? NetworkImage(UserInformation.urlAvatr)
                              : AssetImage('assets/images/photo.png')
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      top: 65,
                      left: 100,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                          gradient: gradientColor,
                        ),
                        child: IconButton(
                          onPressed: () {
                            c.selectImage();
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(UserInformation.first_name,
                  style: redHatMediumStyle(fontSize: 20, color: Colors.black)),
              const SizedBox(
                height: 8,
              ),
              Text('Student',
                  style: redHatMediumStyle(fontSize: 20, color: primaryColor)),
              const SizedBox(
                height: 30,
              ),
              GlobalInfo(
                  fullname: "Full name",
                  name: UserInformation.first_name +
                      ' ' +
                      UserInformation.last_name,
                  icon: Icons.person),
              const Divider(
                indent: 65,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.school,
                          color: gray,
                          size: 27,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Grade',
                                style: redHatMediumStyle(
                                    fontSize: 11, color: gray)),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                UserInformation.grade.toString(),
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: redHatMediumStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.class_,
                          color: gray,
                          size: 27,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Class',
                                style: redHatMediumStyle(
                                    fontSize: 11, color: gray)),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                UserInformation.clasname,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: redHatMediumStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                indent: 65,
              ),
              GlobalInfo(
                fullname: "PhoneNumber",
                name: UserInformation.phone.toString(),
                icon: Icons.call,
              ),
              const Divider(
                indent: 65,
              ),
              GlobalInfo(
                fullname: "Parent",
                name: UserInformation.parentphone.toString(),
                icon: Icons.people,
              ),
              const Divider(
                indent: 65,
              ),
              GlobalInfo(
                fullname: "Fees",
                name:
                    "${UserInformation.fees.toString()} / ${UserInformation.fullfees.toString()}",
                icon: Icons.attach_money,
              ),
              const Divider(
                indent: 65,
              ),
              const SizedBox(
                height: 30,
              ),
              GetBuilder(
                  init: StprofileController(),
                  builder: (controller) => ProgressIndecator(
                        precentage: UserInformation.grade_average,
                        isShow: c.isShow.value,
                        ontap: () {
                          c.showDetails();
                        },
                      )),
              SizedBox(
                height: 35.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50.w),
                  SizedBox(
                    width: 100.w,
                    child: const Center(
                      child: Text(
                        'HomeWork',
                        style: TextStyle(
                            color: darkGray, fontFamily: RedHatDisplay.medium),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    child: const Center(
                      child: Text(
                        'Exam1',
                        style: TextStyle(
                            color: darkGray, fontFamily: RedHatDisplay.medium),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    child: const Center(
                      child: Text(
                        'Test',
                        style: TextStyle(
                            color: darkGray, fontFamily: RedHatDisplay.medium),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70.w,
                    child: const Center(
                      child: Text(
                        'Exam2',
                        style: TextStyle(
                            color: darkGray, fontFamily: RedHatDisplay.medium),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                  height: 200.h,
                  width: 540.w,
                  child: FutureBuilder(
                    future: c.getStudentMark(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingCircle();
                      } else {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GetBuilder(
                              init: StprofileController(),
                              builder: (controller) {
                                return Visibility(
                                  visible: c.isShow.value,
                                  child: ListView.builder(
                                    itemCount: c.studentMarks.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SubjectMarksCard(
                                        subjectname: c.studentMarks.value[index]
                                            .subjectname,
                                        test: c.studentMarks.value[index].test,
                                        homework: c
                                            .studentMarks.value[index].homework,
                                        exam1:
                                            c.studentMarks.value[index].exam1,
                                        exam2:
                                            c.studentMarks.value[index].exam2,
                                      );
                                    },
                                  ),
                                );
                              },
                            ));
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
