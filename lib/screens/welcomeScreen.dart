import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/constants/constants.dart';
import 'package:password_manager/screens/addNewPassword.dart';
import 'package:password_manager/components/customButton.dart';
import 'package:password_manager/screens/myPasswords.dart';
import 'package:password_manager/screens/resetPassword.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = '/welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xff264653),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: "mainLogo",
                child: Image.asset(
                  'images/lock2.png',
                  height: size.height * 0.5,
                  width: size.width * 0.9,
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                ),
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      Get.to(
                        CreateNewPassword(),
                      );
                    },
                    buttonContent:
                        Text("ADD NEW PASSWORD", style: kButtonContentTextStye),
                    width: size.width * 0.7,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                ),
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      Get.to(
                        MyPasswords(),
                      );
                    },
                    buttonContent:
                        Text("MY PASSWORDS", style: kButtonContentTextStye),
                    width: size.width * 0.7,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                ),
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      Get.to(
                        ResetPassword(),
                      );
                    },
                    buttonContent:
                        Text("RESET PASSWORD", style: kButtonContentTextStye),
                    width: size.width * 0.7,
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
