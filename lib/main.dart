import 'package:flutter/material.dart';
import 'package:password_manager/addNewPassword.dart';
import 'package:password_manager/customButton.dart';
import 'welcomeScreen.dart';

void main() {
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
