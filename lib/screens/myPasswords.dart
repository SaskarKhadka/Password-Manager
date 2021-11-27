import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:password_manager/controllers/userController.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/database/fileHandler.dart';
import '../auth/authentication.dart';
import '../main.dart';

class MyPasswords extends StatefulWidget {
  const MyPasswords({Key? key}) : super(key: key);

  @override
  _MyPasswordsState createState() => _MyPasswordsState();
}

class _MyPasswordsState extends State<MyPasswords> {
  @override
  void initState() {
    super.initState();
  }

  bool isCopied = false;
  // File? image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Obx(() {
        if (Get.find<UserController>().userData.isEmpty) {
          return SizedBox.shrink();
        }
        return FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () async {
            final authenticate = await Authentication.authenticate();
            if (authenticate) {
              await FileHandler.downloadCSV();
            } else {
              getSnackBar(
                title: "ERROR!",
                message: "Authentication not found",
              );
            }
          },
          child: Icon(
            EvaIcons.download,
            color: Colors.black,
          ),
        );
      }),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.08,
                bottom: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "PASSWORDS",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: "Montserrat",
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetX<UserController>(
                init: Get.find<UserController>(),
                builder: (userController) {
                  List<dynamic> userData = userController.userData;
                  if (userData.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: size.height * 0.1,
                        // bottom: 0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Passwords",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 10.0),
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              // bottom: 10.0,
                              // left: 20.0,
                              // right: 20.0,
                              ),
                          padding: EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 10.0,
                            bottom: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final ImagePicker _picker = ImagePicker();

                                    final XFile? file = await _picker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (file == null)
                                      return;
                                    else {
                                      final imageFile = File(file.path);
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
                                      List<int> imageBytes =
                                          await imageFile.readAsBytes();
                                      String base64Image =
                                          base64Encode(imageBytes);
                                      Map<String, String> newData = {
                                        "website": userData[index]["website"],
                                        "email": userData[index]["email"],
                                        "img": base64Image,
                                      };
                                      // DatabaseHandler.addData(newData);
                                      await FileHandler.updateImage(newData);
                                      Get.back();
                                      getSnackBar(
                                          title: "SUCCESS!",
                                          message: "Your picture was updated.");
                                    }
                                  } on PlatformException catch (e) {
                                    //show snackbar
                                    getSnackBar(
                                        title: "ERROR!",
                                        message:
                                            "Your picture was not updated.");
                                    print(e);
                                  }
                                },
                                child: CircleAvatar(
                                  // radius: 25.0,
                                  backgroundColor: Colors.transparent,
                                  radius: 26.0,
                                  backgroundImage: userData[index]["img"] !=
                                          null
                                      ? Image.memory(
                                          base64Decode(userData[index]["img"]),
                                        ).image
                                      : Image.asset("images/lock2.png").image,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userData[index]["website"],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      // color: Color(0xffFCA33B),
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    userData[index]["email"],
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      color: Colors.white70,
                                      // color: Color(0xffFCA33B).withOpacity(0.5),

                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final authenticate =
                                          await Authentication.authenticate();
                                      if (authenticate) {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: userData[index]["password"],
                                          ),
                                        );
                                        getSnackBar(
                                          title: "COPIED!",
                                          message:
                                              "Your password is copied to clipboard",
                                        );
                                      } else {
                                        getSnackBar(
                                            title: "ERROR!",
                                            message:
                                                "Authentication not found");
                                      }
                                    },
                                    child: Icon(
                                      EvaIcons.copyOutline,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Get.defaultDialog(
                                        title: 'Delete Record',
                                        content: Text(
                                            'Are you sure you want to continue?'),
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
                                          onPressed: () async {
                                            Get.back();
                                            final authenticate =
                                                await Authentication
                                                    .authenticate();
                                            if (authenticate) {
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(
                                                      color: Colors.white,
                                                      backgroundColor:
                                                          Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              );
                                              await FileHandler.delete(
                                                  userData[index]["email"],
                                                  userData[index]["website"]);
                                              Get.back();
                                            } else {
                                              getSnackBar(
                                                title: "ERROR!",
                                                message:
                                                    "Authentication not found",
                                              );
                                            }
                                          },
                                          child: Text('Yes'),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      EvaIcons.trash2Outline,
                                      color: Colors.redAccent.withOpacity(0.8),
                                      // color: Color(0xffFCA33B),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
