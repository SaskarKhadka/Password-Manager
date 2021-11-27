import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/auth/authentication.dart';
import 'package:password_manager/constants/constants.dart';
import 'package:password_manager/components/customButton.dart';
import 'package:password_manager/screens/welcomeScreen.dart';

class AuthenticationScreen extends StatelessWidget {
  static const String id = "/authenticationScreen";
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xff264653),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: "mainLogo",
              child: Center(
                child: Image.asset(
                  'images/lock2.png',
                  height: size.height * 0.5,
                  width: size.width * 0.8,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Center(
                child: CustomButton(
                  onPressed: () async {
                    final authenticate = await Authentication.authenticate();
                    if (authenticate)
                      Get.offAllNamed(
                        WelcomeScreen.id,
                      );
                  },
                  buttonContent:
                      Text("AUTHENTICATE", style: kButtonContentTextStye),
                  width: size.width * 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
