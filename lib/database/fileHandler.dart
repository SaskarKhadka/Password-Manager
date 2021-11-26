import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:password_manager/controllers/userController.dart';
import 'package:password_manager/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileHandler {
  static late File file;
  static late Directory directory;
  static bool fileExists = false;

  static Future<void> get initFile async {
    directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    file = File("${directory.path}/appData.json");
    fileExists = await file.exists();
    if (!fileExists) {
      await file.create();
      fileExists = true;
    }
  }

  static bool dataExists(List<dynamic> fileData, Map<String, dynamic> newData) {
    for (dynamic data in fileData) {
      if (data["website"] == newData["website"] &&
          data["email"] == newData["email"]) return true;
    }
    return false;
  }

  static Future<void> write(Map<String, dynamic> data) async {
    String initialData = await file.readAsString();
    if (initialData == "") {
      file.writeAsString(json.encode([data]));
      Get.find<UserController>().setData([data]);
    } else {
      List<dynamic> fileData = json.decode(await file.readAsString());
      bool exists = dataExists(fileData, data);
      if (exists) {
        throw "Record already exists";
      }
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

  static Future<void> updatePassword(Map<String, dynamic> newData) async {
    List<dynamic> fileData = json.decode(await file.readAsString());
    int index = 0;
    for (dynamic each in fileData) {
      if (each["website"].toLowerCase() == newData["website"].toLowerCase() &&
          each["email"].toLowerCase() == newData["email"].toLowerCase()) {
        index++;
        each["password"] = newData["password"];
        break;
      }
    }
    if (index == 0) {
      throw "Cannot reset. Password Not found";
    }
    file.writeAsString(json.encode(fileData));
    Get.find<UserController>().setData(fileData);
  }

  static Future<void> updateImage(Map<String, dynamic> newData) async {
    List<dynamic> fileData = json.decode(await file.readAsString());
    for (dynamic each in fileData) {
      if (each["website"].toLowerCase() == newData["website"].toLowerCase() &&
          each["email"].toLowerCase() == newData["email"].toLowerCase()) {
        each["img"] = newData["img"];
        break;
      }
    }
    file.writeAsString(json.encode(fileData));
    Get.find<UserController>().setData(fileData);
  }

  static Future<void> downloadCSV() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.storage,
    ].request();

    if (status[Permission.storage] == PermissionStatus.granted) {
      List<dynamic> fileData = json.decode(await file.readAsString());
      List<List<dynamic>> rows = [];

      List<dynamic> row = [];
      row.add("number");
      row.add("website");
      row.add("email");
      row.add("password");
      rows.add(row);
      for (int i = 0; i < fileData.length; i++) {
        row = [];
        row.add(i);
        row.add(fileData[i]["website"]);
        row.add(fileData[i]["email"]);
        row.add(fileData[i]["password"]);
        rows.add(row);
      }

      File csvFile = File("/storage/emulated/0/Download/passwords.csv");
      String csv = const ListToCsvConverter().convert(rows);
      bool exists = await csvFile.exists();
      if (!exists) {
        csvFile = await csvFile.create();
      }
      await csvFile.writeAsString(csv);
      getSnackBar(title: "SUCCESS!", message: "Download Complete");
    } else {
      getSnackBar(title: "ERROR!", message: "Pemission not granted");
    }
  }
}
