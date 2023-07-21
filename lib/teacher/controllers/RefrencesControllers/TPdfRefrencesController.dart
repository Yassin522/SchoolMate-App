import 'package:get/get.dart';
import 'package:school_management_system/student/models/Adjuncts/refrencesFiles.dart';

import '../../resources/TAdjunctsServices/TAdjunctsServices.dart';

class TRefrencesPdfController extends GetxController {
  var refServicses = TAdjunctsServices();
  var pdfList = [
    /* RefrencesFiles(fileName: 'Hell', subject: 'programming'),
    RefrencesFiles(fileName: 'Nothings', subject: 'Math'),
    RefrencesFiles(fileName: 'bruh', subject: 'Art'),*/
  ].obs;

  getPdfFiles() async {
    pdfList.value = await refServicses.getPdfFiles();
  }
}
