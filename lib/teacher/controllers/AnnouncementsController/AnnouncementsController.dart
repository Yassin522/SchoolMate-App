import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:school_management_system/student/models/Announcements/AnnouncementsModel.dart';
import 'package:school_management_system/teacher/resources/TAnnouncementsServces/TAnnouncementsServices.dart';

class TAnnouncementsController extends GetxController {
  var services = TAnnouncementsServices();
  var announcementsList = [
    AnnouncementsModesl(
      title: 'Hello',
      date: '2022/2/1',
      content: 'lorem puase',
    ),
    AnnouncementsModesl(
      title: 'My',
      date: '2022/2/1',
      content: 'lorem puase',
    ),
    AnnouncementsModesl(
      title: 'Pedro',
      date: '2022/2/1',
      content: 'lorem puase',
    ),
  ].obs;
  var announcementsStream;
  gettAnnucements() async {
    announcementsStream = await services.getAnnouncements();
    return announcementsStream;
  }
}
