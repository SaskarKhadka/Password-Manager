import 'package:flutter/material.dart';
import 'package:password_manager/constants/constants.dart';
import 'package:password_manager/customButton.dart';
import 'package:password_manager/customTextField.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:password_manager/database/databaseHandler.dart';
// import 'package:line_icons/line_icons.dart';

class CreateNewPassword extends StatefulWidget {
  static const String id = "/createNewPassword";

  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController websiteController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    websiteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  bool _inputIsValid() {
    /*
    SOLVE THIS
    */
    // if (websiteController.text.trim().isEmpty) {
    //   // show snackbar showing website field is empty
    //   return false;
    // } else {
    //   if (websiteController.text.isEmail())
    // }
    // if (emailController.text.trim().isEmpty) {
    //   // show snackbar showing website field is empty
    //   return false;
    // }
    // if (passwordController.text.trim().isEmpty) {
    //   // show snackbar showing website field is empty
    //   return false;
    // }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: Color(0xff264653),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
            top: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: "mainLogo",
                child: Image.asset(
                  'images/lock2.png',
                  height: size.height * 0.3,
                  width: size.width * 0.7,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                        controller: websiteController,
                        hintText: "Twitter/Facebook",
                        labelText: "WEBSITE",
                        icon: EvaIcons.globe,
                      ),
                      SizedBox(
                        height: size.height * 0.035,
                      ),
                      CustomTextField(
                        controller: emailController,
                        hintText: "abc@gmail.com",
                        labelText: "EMAIL",
                        icon: EvaIcons.emailOutline,
                      ),
                      SizedBox(
                        height: size.height * 0.035,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hintText: "",
                        labelText: "PASSWORD",
                        icon: EvaIcons.lockOutline,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: size.height * 0.075,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      CustomButton(
                        onPressed: () {
                          // if (_inputIsValid()) {
                          Map data = {
                            "website": websiteController.text.trim(),
                            "email": emailController.text.trim(),
                            "password": passwordController.text.trim(),
                          };
                          DatabaseHandler.addData(data);
                          // }
                        },
                        buttonContent: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              EvaIcons.saveOutline,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "SAVE",
                              style: kButtonContentTextStye,
                            ),
                          ],
                        ),
                        width: size.width * 0.75,
                      ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
