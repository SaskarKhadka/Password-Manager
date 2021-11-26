import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/constants/constants.dart';
import 'package:password_manager/customButton.dart';
import 'package:password_manager/customTextField.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:password_manager/database/fileHandler.dart';
import 'package:password_manager/main.dart';

class ResetPassword extends StatefulWidget {
  static const String id = "/resetPassword";

  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController websiteController;
  late GlobalKey<FormState> globalKey;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    websiteController = TextEditingController();
    globalKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  String? validateWebsite(String? website) {
    if (website!.isEmpty)
      return "Required";
    else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty || password.length < 8) {
      return "Must be at least 8 characters";
    } else {
      return null;
    }
  }

  String? validateEmail(String? email) {
    if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email!))
      return "Email not valid";
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: Color(0xff264653),
        backgroundColor: Colors.black,
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
                  child: Form(
                    key: globalKey,
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
                          labelText: "NEW PASSWORD",
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
                          onPressed: () async {
                            // if (_inputIsValid()) {
                            if (globalKey.currentState!.validate()) {
                              Get.defaultDialog(
                                // buttonColor: Colors.black,
                                title: 'Reset Password',
                                content:
                                    Text('Are you sure you want to continue?'),
                                cancel: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                  ),
                                  onPressed: () => Get.back(),
                                  child: Text('No'),
                                ),
                                confirm: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                  ),
                                  child: Text('Yes'),
                                  onPressed: () async {
                                    Get.back();
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                            backgroundColor: Colors.black,
                                          ),
                                        ],
                                      ),
                                    );
                                    Map<String, String> data = {
                                      "website": websiteController.text.trim(),
                                      "email": emailController.text.trim(),
                                      "password":
                                          passwordController.text.trim(),
                                    };
                                    try {
                                      await FileHandler.updatePassword(data);
                                      Get.back();
                                      getSnackBar(
                                          title: "SUCCESS!",
                                          message:
                                              "Password successfully reset");
                                    } catch (e) {
                                      Get.back();
                                      getSnackBar(
                                          title: "ERROR!",
                                          message: e.toString());
                                    }
                                  },
                                ),
                              );
                            }
                          },
                          buttonContent: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "RESET PASSWORD",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
