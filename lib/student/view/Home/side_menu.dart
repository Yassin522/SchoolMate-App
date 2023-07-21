import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/public/utils/constant.dart';

import '../../../public/utils/font_style.dart';
import '../../../routes/app_pages.dart';
import '../../controllers/home_controller.dart';
import '../../resources/Parent/parentApi.dart';
import '../../resources/complaint/complaintApi.dart';

var homeController = Get.put<HomeController>(HomeController());

class SideMenue extends StatelessWidget {
  get image => null;

  SideMenue({
    this.onPress,
  });
  final onPress;

  final contentController = TextEditingController();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    addcomplaintapi(String content, String title, String id) async {
      bool ok = await ComplaintApi.addComplaintapi(contentController.text,
          titleController.text, UserInformation.User_uId);

      if (ok) {
        homeController.showNotification2(
            'Report', 'The report has been uploaded');
      }
      titleController.clear();
      contentController.clear();
    }

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            InkWell(
              onTap: () {
                if (!UserInformation.uParent) {
                  Get.toNamed(AppPages.Studentprofile);
                }
              },
              child: Container(
                height: 135,
                width: 135,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                      image: NetworkImage(UserInformation.urlAvatr),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: onPress,
                child: Text(UserInformation.first_name,
                    style:
                        redHatMediumStyle(fontSize: 20, color: Colors.grey))),
            const SizedBox(
              height: 30,
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            FutureBuilder(
              future: homeController.getchilds(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Loading...'));
                }

                return homeController.mychilds.isEmpty
                    ? SizedBox(
                        height: 25,
                        child: Center(
                          child: Text(
                            'NO childs',
                          ),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                        itemCount: homeController.mychilds.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = homeController.mychilds[index];
                          return Container(
                            height: 75,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(user.urlAvatar),
                              ),
                              title: TextButton(
                                  onPressed: () {
                                    UserInformation.fees =
                                        UserInformation.classid = user.classid;
                                    UserInformation.first_name = user.firstName;
                                    UserInformation.last_name = user.lastName;
                                    UserInformation.phone = user.phone;
                                    UserInformation.parentphone =
                                        user.parentPhone;
                                    UserInformation.classroom =
                                        user.studentClass;
                                    UserInformation.clasname =
                                        user.studentClass;
                                    UserInformation.urlAvatr = user.urlAvatar;
                                    /* UserInformation.grade_average =
                                        user.average;
                                   UserInformation.grade = user.studentGrade;*/
                                    UserInformation.User_uId = user.id;
                                    UserInformation.email = user.email;
                                    UserInformation.uParent = false;
                                    Phoenix.rebirth(context);
                                    Get.toNamed(AppPages.Splashscreen);
                                  },
                                  child: Text(user.firstName)),
                            ),
                          );
                        },
                      );
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 320,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.line_weight_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  UserInformation.uParent
                      ? SizedBox(height: 1)
                      : TextButton(
                          onPressed: () {
                            Get.defaultDialog(
                                backgroundColor: backgroundColor,
                                title: 'Add Report',
                                titleStyle: redHatMediumStyle(
                                    color: darkGray, fontSize: 28),
                                contentPadding: EdgeInsets.all(20),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      onChanged: (value) {
                                        print(value);
                                      },
                                      controller: titleController,
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        labelText: 'Title',
                                        hintMaxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    TextField(
                                      onChanged: (value) {},
                                      controller: contentController,
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        labelText: 'Content',
                                        hintMaxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // c.update();
                                              addcomplaintapi(
                                                  contentController.text,
                                                  titleController.text,
                                                  UserInformation.User_uId);
                                              Get.back();
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 110,
                                              color: primaryColor,
                                              child: Center(
                                                child: Text(
                                                  'submit',
                                                  style: redHatBoldStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 110,
                                              color: Colors.white,
                                              child: Center(
                                                child: Text(
                                                  'cancel',
                                                  style: redHatBoldStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                radius: 10.0);
                          },
                          child: Text(
                            "Report (write a complaint)",
                            style:
                                sfMediumStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: 320,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.logout,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppPages.INITIAL);
                    },
                    child: Text(
                      "log out",
                      style: sfMediumStyle(fontSize: 16, color: Colors.grey),
                    ),
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
