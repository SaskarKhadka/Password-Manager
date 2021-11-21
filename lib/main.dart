import 'package:flutter/material.dart';
import 'package:password_manager/addNewPassword.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/database/databaseHandler.dart';
import 'welcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("userData");
  runApp(PasswordManager());
}

class PasswordManager extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
