import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_style.dart';
import 'package:school_management_system/student/Widgets/CustomAppBar.dart';
import 'package:school_management_system/student/Widgets/custom_progress_indecator.dart';
import 'package:school_management_system/student/Widgets/global_info.dart';
import 'package:school_management_system/teacher/controllers/TProfilesController/TProfileController.dart';
import 'package:school_management_system/teacher/view/Home/homeFlashbar.dart';
import 'package:school_management_system/teacher/view/tasks/AddFiles/components/SelectFile.dart';

var _controller = Get.put(TProfileController());

class TProfileScreen extends StatelessWidget {
  const TProfileScreen({Key? key}) : super(key: key);

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
              GetBuilder<TProfileController>(
                init: TProfileController(), // INIT IT ONLY THE FIRST TIME
                builder: (TProfileController controller) => Stack(
                  children: [
                    //controller.teacherInfo.value.photoUrl == "GG"
                    /*Container(
                      height: 135,
                      width: 135,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/photo.png'),
                        ),
                      ),
                    ),*/
                    GetBuilder<TProfileController>(
                        init: TProfileController(),
                        builder: (c) {
                          return Container(
                            height: 135,
                            width: 135,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                              image: DecorationImage(
                                image: (controller.teacherInfo.value.photoUrl ==
                                        null)
                                    ? AssetImage('assets/images/photo.png')
                                        as ImageProvider
                                    : NetworkImage(
                                        controller.teacherInfo.value.photoUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
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
                          onPressed: () async {
                            Uint8List img =
                                await pickImage(ImageSource.gallery);
                            await controller.updateImage(img);
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
              Text('${_controller.teacherInfo.value.fname}',
                  style: redHatMediumStyle(fontSize: 20, color: Colors.black)),
              const SizedBox(
                height: 8,
              ),
              Text('Teacher',
                  style: redHatMediumStyle(fontSize: 20, color: primaryColor)),
              const SizedBox(
                height: 30,
              ),
              GlobalInfo(
                  fullname: "Full name",
                  name:
                      '${_controller.teacherInfo.value.fname} ${_controller.teacherInfo.value.lname}',
                  icon: Icons.person),
              const Divider(
                indent: 65,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.book_outlined,
                      color: gray,
                      size: 27,
                    ),
                    const SizedBox(width: 20),
                    Text('Subjects',
                        style: redHatMediumStyle(fontSize: 11, color: gray)),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 200.w,
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            _controller.teacherInfo.value.subjects.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: gradientColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      '${_controller.teacherInfo.value.subjects[index].subjectName}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: redHatMediumStyle(
                                        fontSize: 16,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                                child: Center(
                                  child: Text(' | '),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                indent: 65,
              ),
              GlobalInfo(
                fullname: "Email",
                name: _controller.teacherInfo.value.email,
                icon: Icons.email,
              ),
              const Divider(
                indent: 65,
              ),
              GlobalInfo(
                  fullname: "About",
                  name: '${_controller.teacherInfo.value.about}',
                  icon: Icons.info_outline),
              const Divider(
                indent: 65,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
