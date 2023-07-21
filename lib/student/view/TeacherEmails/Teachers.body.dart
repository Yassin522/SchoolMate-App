import 'package:flutter/material.dart';
import 'package:school_management_system/student/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class TeachersBodyWidget extends StatelessWidget {
  final List<User> users;

  const TeachersBodyWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];

          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                print(user.idUser);
                print("teacherrrrrrrrrrr");

                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((MapEntry<String, String> e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: user.email,
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Example Subject & Symbols are allowed!',
                  }),
                );

                launchUrl(emailLaunchUri);
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.urlAvatar!),
              ),
              title: Text(user.first_name!),
            ),
          );
        },
        itemCount: users.length,
      );
}
