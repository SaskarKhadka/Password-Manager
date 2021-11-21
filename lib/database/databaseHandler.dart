import 'package:hive/hive.dart';

class DatabaseHandler {
  // static late Box box;

  static Box get getBox {
    return Hive.box("userData");
  }

  static addData(Map data) {
    final box = getBox;
    box.put(data["website"], [data]);
  }

  static getData(String key) {}
  static updateData(Map data) {}
  static removeData(Map data) {}
}
