
import 'package:flutter/material.dart';
import 'package:school_management_system/public/utils/constant.dart';

import '../../Widgets/messages_widget.dart';
import '../../Widgets/new_message_widget.dart';
import '../../Widgets/profile_header_widget.dart';
import '../../models/user.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.first_name),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(idUser: widget.user.idUser),
                ),
              ),
              NewMessageWidget(idUser: widget.user.idUser)
            ],
          ),
        ),
      );
}
