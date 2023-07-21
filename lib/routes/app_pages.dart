import 'package:get/get.dart';
import 'package:school_management_system/public/login/verify_code_parent.dart';
import 'package:school_management_system/public/splash/splash_scrren.dart';
import 'package:school_management_system/student/binding/announcements.dart';
import 'package:school_management_system/student/binding/chatSearch.dart';
import 'package:school_management_system/student/binding/lesson.dart';
import 'package:school_management_system/student/binding/refrences.dart';
import 'package:school_management_system/student/binding/tasks.dart';
import 'package:school_management_system/student/view/Announcements/AnnouncementsPage.dart';
import 'package:school_management_system/student/view/Chat/chats_page.dart';
import 'package:school_management_system/student/view/Home/home.dart';
import 'package:school_management_system/student/view/Profile/stprofile.dart';
import 'package:school_management_system/student/view/Subjects/SubjectsScreen.dart';
import 'package:school_management_system/student/view/TasksScreen/TasksPage.dart';
import 'package:school_management_system/teacher/binding/lessonBinding.dart';
import 'package:school_management_system/teacher/view/Home/HomeBody.dart';
import 'package:school_management_system/teacher/view/TSubject/Subjects/SubjectScreen.dart';
import 'package:school_management_system/teacher/view/TSubject/TSubjectsInfo.dart';
import 'package:school_management_system/teacher/view/TSubject/TlessonScreen.dart';

import '../parent/view/home.dart';
import '../public/login/login_screen.dart';
import '../public/login/verify_code_teacher.dart';
import '../student/binding/home.dart';
import '../student/binding/profile.dart';
import '../student/view/Adjuncts/adjuncts.dart';
import '../student/view/chatSearch/chat_search.dart';
import '../teacher/binding/StudentsOfTaskBinding.dart';
import '../teacher/binding/TAdjunctsBinding.dart';
import '../teacher/view/Adjuncts/TeacherAdjuncts.dart';
import '../teacher/view/Home/teacher_home.dart';
import '../teacher/view/TaskScreen/task_screen.dart';
import '../teacher/view/tasks/studentsOfTask.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/login';
  static const Studentprofile = '/stprofile';
  static const Splashscreen = '/splash';
  static const Studenthome = '/sthome';
  static const Teacherhome = '/teahome';
  static const Verifycode = '/verify';
  static const VerifyCodeparent = '/verifyparent';
  static const Parenthome = '/parhome';
  static const tasks = '/tasks';
  static const adjuncts = '/adjuncts';
  static const announcements = '/announcements';
  static const subjects = '/subjects';
  static const ChatStudent = '/chatstudent';
  static const Chatsearch = '/chatsearch';
  static const taskTeacher = '/taskteacher';
  static const tsubjectinfo = '/tsubjectinfo';
  static const tsubjects = '/tsubjectlist';
  static const studentsOfTask = '/studentsOfTask';
  static const tadjuncts = '/tadjuncts';
  static final routes = [
    GetPage(
      name: INITIAL,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Studentprofile,
      page: () => StudentProfile(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Splashscreen,
      page: () => Splash(),
    ),
    GetPage(
      name: Studenthome,
      page: () => HomeStudent(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Verifycode,
      page: () => Otp(),
    ),
    GetPage(
      name: VerifyCodeparent,
      page: () => OtpParent(),
    ),
    GetPage(
      name: Parenthome,
      page: () => HomeParent(),
    ),
    GetPage(
      name: tasks,
      page: () => TasksPage(),
      binding: TasksBinding(),
    ),
    GetPage(
      name: adjuncts,
      page: () => const Refrences(),
      binding: RefrencesBinding(),
    ),
    GetPage(
      name: announcements,
      page: () => const AnnouncementsPage(),
      binding: AnnouncementsBinding(),
    ),
    GetPage(
      name: subjects,
      page: () => const SubjectsScreen(),
      binding: LessonsBinding(),
    ),
    GetPage(
      name: ChatStudent,
      page: () => ChatsPage(),
    ),
    GetPage(
      name: Chatsearch,
      page: () => ChatSearch(),
      binding: ChatSearchBinding(),
    ),
    GetPage(
      name: Teacherhome,
      page: () => HomeBody(),
    ),
    GetPage(
      name: taskTeacher,
      page: () => TaskScreen(),
    ),
    GetPage(
      name: tsubjectinfo,
      page: () => TSubjectScreen(),
    ),
    GetPage(
      name: tsubjects,
      page: () => SubjectsListScreen(),
    ),
    GetPage(
      name: studentsOfTask,
      page: () => StudentsOfTask(),
      binding: StudentsOfTaskBinding(),
    ),
    GetPage(
      name: tadjuncts,
      page: () => TeacherAdjuncts(),
      binding: TAdjunctsBinding(),
    ),
  ];
}
