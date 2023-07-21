import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/student/controllers/SearchController.dart';
import 'package:school_management_system/student/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../public/utils/constant.dart';
import '../../Widgets/Chatappbar.dart';
import '../../resources/chat/chat_api.dart';
import '../Chat/chat_page.dart';

class ChatSearch extends StatelessWidget {
  ChatSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: gradientColor),
        ),
        actions: [
          Row(
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(right: 12.w, top: 10.h, bottom: 26.5.h),
                  child: IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: MySearchDelegate(),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 27,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SafeArea(
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
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final user = users[index];

                          return Container(
                            height: 75,
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatPage(user: user),
                                ));
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
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}

class MySearchDelegate extends SearchDelegate {
  SearchController controller = Get.put(SearchController());
  final teachersNames = ["Yassin", "osama"];

  final recentTeachers = [];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else
                query = '';
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    print("nowwwwwwwwww");
    print(query);
    OnClickSearch(query);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = controller.searchResult[index];
          print("hhhhhhhhhh");
          print(user.idUser);

          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(user: user),
                ));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.urlAvatar),
              ),
              title: Text(user.first_name),
            ),
          );
        },
        itemCount: controller.searchResult.length,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentTeachers
        : teachersNames.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.school),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }

  void OnClickSearch(String query) async {
    await controller.loadSearchByName(query);
    if (controller.searchStatus) {
      print('success');
      print(controller.searchResult);
    }
  }
}
