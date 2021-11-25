import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/addNewPassword.dart';
import 'package:password_manager/controllers/userController.dart';
import 'package:password_manager/database/fileHandler.dart';
import 'welcomeScreen.dart';

// late List<dynamic> fileData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // await Hive.openBox("userData");
  UserController userController = Get.put(UserController());
  await FileHandler.initFile;
  userController.setData(await FileHandler.read());
  runApp(PasswordManager());
}

class PasswordManager extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      title: 'Password Manager',
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        CreateNewPassword.id: (context) => CreateNewPassword(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
