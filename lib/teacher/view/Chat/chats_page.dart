import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/routes/app_pages.dart';
import 'package:school_management_system/teacher/model/user.dart';
import 'package:school_management_system/teacher/resources/chat/chat_api.dart';
import 'package:school_management_system/teacher/widgets/chat_body_widget.dart';
import 'package:school_management_system/teacher/widgets/chat_header_widget.dart';



class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppPages.Chatsearch);
          },
          child: Icon(Icons.search),
          focusColor: primaryColor,
          hoverColor: primaryColor,
          splashColor: primaryColor,
          backgroundColor: primaryColor,
        ),
        backgroundColor: primaryColor,
        body: SafeArea(
          child: StreamBuilder<List<User>>(
            stream: FirebaseApi.getUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Something Went Wrong Try later');
                  } else {
                    final users = snapshot.data!;

                    if (users.isEmpty) {
                      return buildText('No Users Found');
                    } else
                      return Column(
                        children: [
                          ChatHeaderWidget(users: users),
                          ChatBodyWidget(users: users)
                        ],
                      );
                  }
              }
            },
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
}
