import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/addNewPassword.dart';
import 'package:password_manager/controllers/userController.dart';
import 'package:password_manager/database/fileHandler.dart';
import 'package:password_manager/resetPassword.dart';
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
        ResetPassword.id: (context) => ResetPassword(),
      },
      theme: ThemeData(
        primaryColor: Colors.black,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black,
        ), // primaryColorLight: Colors.white,
        // primaryColorDark: Colors.black,
        textSelectionTheme: TextSelectionThemeData(
          // selectionHandleColor: Color(0xffFCA33B),
          selectionHandleColor: Colors.white,
          // cursorColor: Color(0xffFCA33B),
          selectionColor: Color(0xffFCA33B),
        ),
        // primarySwatch: MaterialColor(
        //   0xff131313,
        //   <int, Color>{
        //     50: Color(0xff131313).withOpacity(0.1), //10%
        //     100: Color(0xff131313).withOpacity(0.2), //20%
        //     200: Color(0xff131313).withOpacity(0.3), //30%
        //     300: Color(0xff131313).withOpacity(0.4), //40%
        //     400: Color(0xff131313).withOpacity(0.5), //50%
        //     500: Color(0xff131313).withOpacity(0.6), //60%
        //     600: Color(0xff131313).withOpacity(0.7), //70%
        //     700: Color(0xff131313).withOpacity(0.8), //80%
        //     800: Color(0xff131313).withOpacity(0.9), //90%
        //     900: Color(0xff131313).withOpacity(1), //100%
        //   },
        // ),
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
