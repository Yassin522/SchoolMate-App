import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/public/utils/constant.dart';

import '../../../../../main.dart';

Future selectfile() async {
  File? file;
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  if (result == null) return;
  final path = result.files.single.path;

  file = File(path!);
  return file;
}

Future uploadfileToFirebase({var file, String? destination}) async {
  print('upload start');

  if (file == null) return;

  print(destination);
  var task = await FirebaseStorage.instance.ref(destination);
  print('ref  start');
  await task.putFile(file);
  print('file uploaded');
  var urlDownload = await task.getDownloadURL();
  print('3aaaaaaaaaaaaaaaaaa');
  print('Download-link : $urlDownload');

  return urlDownload;
}

uploadImageToStorage(String destination, Uint8List file) async {
  Reference ref = FirebaseStorage.instance.ref(destination);
  await ref.putData(file);
  String downloadUrl = await ref.getDownloadURL();
  print(downloadUrl);
  return downloadUrl;
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
}

showNotification(String filename, String path) {
  flutterLocalNotificationsPlugin.show(
      0,
      filename,
      "The file has been downloaded\n$path",
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              importance: Importance.high,
              color: primaryColor,
              playSound: true,
              icon: '@mipmap/ic_launcher')));
}
