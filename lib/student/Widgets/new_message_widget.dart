import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management_system/public/utils/constant.dart';
import '../../public/config/user_information.dart';
import '../resources/chat/chat_api.dart';
import 'package:school_management_system/student/view/Home/messaging.dart';
class NewMessageWidget extends StatefulWidget {
  final String? idUser;

  const NewMessageWidget({
    required this.idUser,
    Key? key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    var name =UserInformation.first_name;
 

    FocusScope.of(context).unfocus();

    await FirebaseApi.uploadMessage(widget.idUser, message);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  filled: true,
                  hintText: 'Message',
                  hintStyle: TextStyle(fontSize: 15),
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            ),
          ],
        ),
      );
}
