import 'package:flutter/material.dart';

import '../resources/chat/chat_data.dart';
import '../models/chat/message.dart';
import '../resources/chat/chat_api.dart';
import 'message_widget.dart';

class MessagesWidget extends StatelessWidget {
  final String? idUser;

  const MessagesWidget({
    required this.idUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: FirebaseApi.getMessages(idUser),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data!;

                return messages.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          if (message.idUser == myId ||
                              message.idUser == idUser) {
                            return MessageWidget(
                              message: message,
                              isMe: message.idUser == myId,
                            );
                          }
                          return SizedBox(
                            height: 1,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
