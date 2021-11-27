import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/screens/addNewPassword.dart';
import 'package:password_manager/screens/authenticationScreen.dart';
import 'package:password_manager/controllers/userController.dart';
import 'package:password_manager/database/fileHandler.dart';
import 'package:password_manager/screens/resetPassword.dart';
import 'screens/welcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: AuthenticationScreen.id,
      title: 'Password Manager',
      getPages: [
        GetPage(
          name: AuthenticationScreen.id,
          page: () => AuthenticationScreen(),
        ),
        GetPage(
          name: WelcomeScreen.id,
          page: () => WelcomeScreen(),
        ),
        GetPage(
          name: CreateNewPassword.id,
          page: () => CreateNewPassword(),
        ),
        GetPage(
          name: ResetPassword.id,
          page: () => ResetPassword(),
        ),
      ],
      theme: ThemeData(
        primaryColor: Colors.black,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black,
        ), // primaryColorLight: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.white,
          selectionColor: Color(0xffFCA33B),
        ),
      ),
    );
  }
}

getSnackBar({String? title, String? message}) {
  Get.snackbar(
    title!,
    message!,
    titleText: Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontFamily: "Montserrat",
      ),
    ),
    messageText: Text(
      message,
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.white,
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    margin: EdgeInsets.all(15.0),
    padding: EdgeInsets.all(15.0),
    backgroundColor: Color(0xff131313),
    snackStyle: SnackStyle.FLOATING,
  );
}
