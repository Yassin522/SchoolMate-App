import 'package:get/get.dart';
import 'package:school_management_system/student/models/Adjuncts/refrencesVideos.dart';
import 'package:school_management_system/teacher/resources/TAdjunctsServices/TAdjunctsServices.dart';

class TVideosController extends GetxController {
  var refServices = TAdjunctsServices();
  var VideosList = [
    /*RefrencesVideos(
      url: '',
      subject: 'Math',
      videoName: 'any',
    ),
    RefrencesVideos(
      url: '',
      subject: 'Math',
      videoName: 'any',
    ),
    RefrencesVideos(
      url: '',
      subject: 'Math',
      videoName: 'any',
    ),*/
  ].obs;

  getVideos() async {
    VideosList.value = await refServices.getVideos();
  }
}
