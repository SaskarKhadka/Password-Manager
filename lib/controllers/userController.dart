import 'package:get/get.dart';

class UserController extends GetxController {
  var _userData = RxList<dynamic>([]);

  List<dynamic> get userData => _userData;

  void setData(List<dynamic> newData) {
    _userData.value = newData;
  }
}
