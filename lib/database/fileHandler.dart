import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:password_manager/controllers/userController.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  static late File file;
  static late Directory directory;
  static bool fileExists = false;

  static Future<void> get initFile async {
    directory = await getApplicationDocumentsDirectory();
    file = File("${directory.path}/appData.json");
    fileExists = await file.exists();
    if (!fileExists) {
      await file.create();
      fileExists = true;
    }
  }

  static Future<void> write(Map<String, dynamic> data) async {
    String initialData = await file.readAsString();
    if (initialData == "") {
      file.writeAsString(json.encode([data]));
      Get.find<UserController>().setData([data]);
    } else {
      List<dynamic> fileData = json.decode(await file.readAsString());
      // fileData.addAll(data);
      fileData.add(data);
      file.writeAsString(json.encode(fileData));
      Get.find<UserController>().setData(fileData);
    }
  }

  static Future<List<dynamic>> read() async {
    String data = await file.readAsString();
    if (data == "") {
      return [];
    }
    List<dynamic> fileData = json.decode(data);
    return fileData;
  }

  static Future<void> delete(String email, String website) async {
    List<dynamic> fileData = json.decode(await file.readAsString());
    for (dynamic each in fileData) {
      if (each["website"].toLowerCase() == website.toLowerCase() &&
          each["email"].toLowerCase() == email.toLowerCase()) {
        fileData.remove(each);
        break;
      }
    }
    file.writeAsString(json.encode(fileData));
    Get.find<UserController>().setData(fileData);
  }
}
