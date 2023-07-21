import 'package:get/state_manager.dart';

import '../../model/subject/TMarksModel.dart';
import '../../resources/ProfilesServices/SProfileservices.dart';

class DropMenuController extends GetxController {
  var services = SprofileServices();
  var selectedValue = ''.obs;
  var dropdownItems = [].obs;

  var subjectsDrop = Map<String, String>().obs;
  var subjectNames = [].obs;
  var markType = ['Tests', 'HomeWorks', 'Exam1', 'Exam2'].obs;
  var selectedType = 'Tests'.obs;
  var mark = ''.obs;
  var fmark = ''.obs;
  var uid = ''.obs;
  var grade = ''.obs;

  updateUI(newValue) {
    selectedValue.value = newValue;
    update();
  }

  updatetype(newValue) {
    selectedType.value = newValue.toString();
    update();
  }

  addMark() async {
    print(subjectsDrop.value[selectedValue.value.toString()]);
    print(selectedType.value.toLowerCase());
    print(fmark.value);
    print(mark.value);
    print(uid.value);
    print(grade.value);
    var item = AddingMarkModel(
      subject: subjectsDrop.value[selectedValue.value.toString()].toString(),
      type: selectedType.value.toLowerCase(),
      fmark: int.parse(fmark.value),
      mark: int.parse(mark.value),
      uid: uid.value,
      grade: grade.value,
    );

    await services.addMark(item);
    update();
  }
}
