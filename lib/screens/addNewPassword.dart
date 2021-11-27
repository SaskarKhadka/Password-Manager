import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/constants/constants.dart';
import 'package:password_manager/components/customButton.dart';
import 'package:password_manager/components/customTextField.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:password_manager/database/fileHandler.dart';
import 'package:password_manager/main.dart';
import '../auth/authentication.dart';

extension StringExtension on String {
  String toTitleCase() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

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
                    // autovalidateMode: AutovalidateMode.always,
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
                          isEmail: true,
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
                          onPressed: () async {
                            if (globalKey.currentState!.validate())
                              Get.defaultDialog(
                                title: 'Add Record',
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
                                    final authenticate =
                                        await Authentication.authenticate();
                                    if (authenticate) {
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
                                        "website": websiteController.text
                                            .trim()
                                            .toTitleCase(),
                                        "email": emailController.text.trim(),
                                        "password":
                                            passwordController.text.trim(),
                                      };
                                      try {
                                        await FileHandler.write(data);
                                        Get.back();
                                        websiteController.clear();
                                        emailController.clear();
                                        passwordController.clear();
                                        getSnackBar(
                                            title: "SUCCESS!",
                                            message:
                                                "Record successfully added.");
                                      } catch (e) {
                                        Get.back();
                                        getSnackBar(
                                          title: "ERROR!",
                                          message: e.toString(),
                                        );
                                      }
                                    } else {
                                      getSnackBar(
                                          title: "ERROR!",
                                          message: "Authentication not found");
                                    }
                                  },
                                ),
                              );

                            // setState(() {});
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
