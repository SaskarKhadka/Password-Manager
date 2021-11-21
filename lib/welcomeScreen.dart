import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_manager/constants/constants.dart';
import 'package:password_manager/addNewPassword.dart';
import 'package:password_manager/customButton.dart';
import 'package:password_manager/myPasswords.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = '/welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xff264653),
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
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                ),
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CreateNewPassword.id);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPasswords(),
                        ),
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
                    onPressed: () {},
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
      // appBar: AppBar(
      //   leading: null,
      //   title: Text("Password Manager"),
      //   backgroundColor: Colors.pinkAccent,
      //   centerTitle: true,
      // ),
    );
  }
}
