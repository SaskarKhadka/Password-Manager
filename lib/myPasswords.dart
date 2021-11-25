import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:password_manager/controllers/userController.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/database/fileHandler.dart';

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
  File? image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          // gradient: LinearGradient(
          //   colors: [
          //     Color(0xffFFB238),
          //     Color(0xffFFB238).withOpacity(0.9),
          //     // Color(0xffF19143),
          //   ],
          // ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.08,
                bottom: 20.0,
                // left: 30.0,
                // right: 60.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hero(
                  //   tag: "mainLogo",
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 8.0),
                  //     child: CircleAvatar(
                  //       radius: 30.0,
                  //       // backgroundColor: Colors.white,
                  //       backgroundColor: Colors.transparent,
                  //       child: Image.asset(
                  //         "images/lock2.png",
                  //         height: size.height * 0.2,
                  //         width: size.width * 0.3,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Icon(
                  //   EvaIcons.arrowBackOutline,
                  //   color: Colors.white,
                  // ),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  Text(
                    "PASSWORDS",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: "Montserrat",
                      color: Colors.white,
                      // color: Color(0xffFCA33B),
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
                                Container(
                                  // radius: 25.0,
                                  height: 50.0,
                                  width: 50.0,
                                  child: Image.asset("images/lock2.png"),
                                  color: Colors.transparent,
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
                                        // fontWeight: FontWeight.bold,
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
                                      onTap: () {
                                        // if (!isCopied)
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: userData[index]["password"],
                                          ),
                                        );
                                        // setState(() => isCopied = true);
                                      },
                                      // child: isCopied
                                      //     ? Icon(
                                      //         EvaIcons.checkmark,
                                      //         color: Colors.green,
                                      //       )
                                      //     : Icon(
                                      //         EvaIcons.copyOutline,
                                      //         color: Colors.white,
                                      //         // color: Color(0xffFCA33B),
                                      //       ),
                                      child: Icon(
                                        EvaIcons.copyOutline,
                                        color: Colors.green,
                                        // color: Color(0xffFCA33B),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await FileHandler.delete(
                                            userData[index]["email"],
                                            userData[index]["website"]);
                                        // List<dynamic> newData =
                                        //     await FileHandler.read();
                                        // setState(() {
                                        //   userData = newData;
                                        // });
                                      },
                                      child: Icon(
                                        EvaIcons.trash2Outline,
                                        color:
                                            Colors.redAccent.withOpacity(0.8),
                                        // color: Color(0xffFCA33B),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),

      //   ],
      // ),
    );
  }
}


// import 'dart:convert';
// import 'dart:io';

// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:password_manager/database/databaseHandler.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';

// class MyPasswords extends StatefulWidget {
//   const MyPasswords({Key? key}) : super(key: key);

//   @override
//   _MyPasswordsState createState() => _MyPasswordsState();
// }

// class _MyPasswordsState extends State<MyPasswords> {
//   File? image;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       // appBar: AppBar(
//       //   shadowColor: Colors.transparent,
//       //   title: Text(
//       //     "PASSWORDS",
//       //     textAlign: TextAlign.center,
//       //     style: TextStyle(
//       //       fontSize: 30.0,
//       //       fontFamily: "Montserrat",
//       //       color: Colors.black,
//       //     ),
//       //   ),
//       //   toolbarHeight: 60,
//       //   centerTitle: true,
//       //   // backgroundColor: Color(0xffFCA33B),
//       //   backgroundColor: Colors.transparent,
//       // ),
//       // backgroundColor: Color(0xffFFB238),
//       // backgroundColor: Color(0xff0d0907),
//       // body: Stack(
//       //   children: [
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.black,
//           gradient: LinearGradient(colors: [
//             Color(0xffF19143),
//             // Color(0xffFFB238),
//             Color(0xffFFB238).withOpacity(0.9),
//             Color(0xffFFB238).withOpacity(0.8),
//           ]),
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.only(
//                 top: 30.0,
//                 bottom: 20.0,
//                 left: 20.0,
//                 right: 20.0,
//               ),
//               margin: EdgeInsets.only(
//                 top: size.height * 0.075,
//               ),
//               // color: Color(),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       Hero(
//                         tag: "mainLogo",
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: CircleAvatar(
//                             radius: 40.0,
//                             // backgroundColor: Colors.white,
//                             backgroundColor: Colors.transparent,
//                             child: Image.asset(
//                               "images/lock2.png",
//                               height: size.height * 0.2,
//                               width: size.width * 0.3,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10.0,
//                       ),
//                       Text(
//                         "PASSWORDS",
//                         // textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 30.0,
//                           fontFamily: "Montserrat",
//                           // color: Color(0xffFCA33B),
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.03,
//                   ),
//                   Container(
//                     // decoration: BoxDecoration(boxShadow: [
//                     //   BoxShadow(
//                     //     color: Colors.white.withOpacity(0.5),
//                     //     blurRadius: 3,
//                     //     spreadRadius: 10,
//                     //     offset: Offset(5, 10),
//                     //   ),
//                     // ]),
//                     height: 55,
//                     child: TextField(
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'Montserrat',
//                         color: Colors.black,
//                       ),
//                       cursorColor: Colors.black,
//                       decoration: InputDecoration(
//                         hintText: "Search passwords",
//                         hintStyle: TextStyle(
//                           color: Colors.grey,
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         suffixIcon: GestureDetector(
//                           onTap: () {},
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Icon(
//                               EvaIcons.search,
//                               // color: Color(0xffFCA33B),
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         border: InputBorder.none,
//                         // focusedBorder: OutlineInputBorder(
//                         //   borderRadius: BorderRadius.circular(10.0),
//                         //   borderSide: BorderSide(
//                         //     // color: Color(0xffFCA33B),
//                         //     color: Colors.black,
//                         //     width: 2.0,
//                         //     style: BorderStyle.none,
//                         //   ),
//                         // ),
//                         // enabledBorder: OutlineInputBorder(
//                         //   borderRadius: BorderRadius.circular(10.0),
//                         //   borderSide: BorderSide(
//                         //     // color: Color(0xffFCA33B),
//                         //     color: Colors.black,
//                         //     width: 1.5,
//                         //     style: BorderStyle.none,
//                         //   ),
//                         // ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(top: 10.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     // topRight: Radius.circular(40.0),
//                     topLeft: Radius.circular(40.0),
//                   ),
//                 ),
//                 child: ValueListenableBuilder(
//                   valueListenable: DatabaseHandler.getBox.listenable(),
//                   builder: (context, Box box, _) {
//                     List data = box.values.toList().cast<List>();
//                     return ListView.builder(
//                         padding: EdgeInsets.only(top: 30.0),
//                         itemCount: data.length,
//                         // physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return Container(
//                             // Color(0xffFFB238),
//                             // Color(0xffF19143),
//                             height: 80,
//                             margin: EdgeInsets.only(
//                               bottom: 25.0,
//                               left: 20.0,
//                               right: 20.0,
//                             ),
//                             padding: EdgeInsets.only(
//                               right: 15.0,
//                               left: 5.0,
//                             ),
//                             // height: size.height * 0.1,
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.circular(15.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.3),
//                                   spreadRadius: 2,
//                                   blurRadius: 10,
//                                   offset: Offset(5, 10),
//                                 ),
//                               ],
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color(0xffF19143),
//                                   // Color(0xffFFB238),
//                                   Color(0xffFFB238).withOpacity(0.9),
//                                   Color(0xffFFB238).withOpacity(0.8),
//                                   // Color(0xffFFB238),
//                                 ],
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () async {
//                                     try {
//                                       final ImagePicker _picker = ImagePicker();

//                                       final XFile? file =
//                                           await _picker.pickImage(
//                                         source: ImageSource.gallery,
//                                       );
//                                       if (file == null)
//                                         return;
//                                       else {
//                                         final imageFile = File(file.path);
//                                         List<int> imageBytes =
//                                             await imageFile.readAsBytes();
//                                         setState(() {
//                                           this.image = imageFile;

//                                           // print(imageBytes);
//                                           String base64Image =
//                                               base64Encode(imageBytes);
//                                           Map newData = {
//                                             "website": data[index][0]
//                                                 ["website"],
//                                             "email": data[index][0]["email"],
//                                             "password": data[index][0]
//                                                 ["password"],
//                                             "img": base64Image,
//                                           };
//                                           DatabaseHandler.addData(newData);
//                                         });
//                                       }
//                                     } on PlatformException catch (e) {
//                                       //show snackbar
//                                       print(e);
//                                     }
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(50),
//                                       // radius: 30.0,
//                                       // backgroundColor: Colors.white,
//                                       // backgroundColor: Colors.transparent,
//                                       child: data[index][0]["img"] != null
//                                           // Image.memory(base64Decode(base64String))
//                                           ? Image.memory(
//                                               base64Decode(
//                                                   data[index][0]["img"]),
//                                               height: 50,
//                                               width: 50,
//                                               fit: BoxFit.cover,
//                                             )
//                                           : Image.asset(
//                                               "images/lock2.png",
//                                               height: 60.0,
//                                               width: 60.0,
//                                             ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     top: 15.0,
//                                     bottom: 15.0,
//                                     left: 20.0,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "${data[index][0]["website"].toUpperCase()}",
//                                         style: TextStyle(
//                                           fontSize: 20.0,
//                                           color: Colors.black,
//                                           fontFamily: "Montserrat",
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           "${data[index][0]["email"]}",
//                                           style: TextStyle(
//                                             fontSize: 12.0,
//                                             color: Colors.black,
//                                             fontFamily: "Montserrat",
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 15.0),
//                                   child: Row(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           Clipboard.setData(
//                                             ClipboardData(
//                                               text: data[index][0]["password"],
//                                             ),
//                                           );
//                                         },
//                                         child: Icon(
//                                           Icons.edit,
//                                           color: Colors.black,
//                                           size: 24.0,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 15.0,
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           Clipboard.setData(
//                                             ClipboardData(
//                                               text: data[index][0]["password"],
//                                             ),
//                                           );
//                                         },
//                                         child: Icon(
//                                           Icons.copy,
//                                           color: Colors.black,
//                                           size: 24.0,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         });
//                     // return ListView.builder(
//                     //   physics: NeverScrollableScrollPhysics(),
//                     //   padding: EdgeInsets.only(
//                     //     top: 35.0,
//                     //   ),
//                     //   itemCount: data.length,
//                     //   itemBuilder: (context, index) {
//                     //     return GestureDetector(
//                     //       onTap: () {},
//                     //       child: Container(
//                     //         // Color(0xffFFB238),
//                     //         // Color(0xffF19143),
//                     //         margin: EdgeInsets.only(
//                     //           bottom: 25.0,
//                     //           left: 20.0,
//                     //           right: 20.0,
//                     //         ),
//                     //         padding: EdgeInsets.only(
//                     //           right: 10.0,
//                     //           left: 5.0,
//                     //         ),
//                     //         height: size.height * 0.1,
//                     //         decoration: BoxDecoration(
//                     //           borderRadius: BorderRadius.circular(10.0),
//                     //           // color: Color(0xff0d0907).withOpacity(0.9),
//                     //           // color: Colors.white,
//                     //           color: Color(0xffFCA33B).withOpacity(0.9),
//                     //           boxShadow: [
//                     //             BoxShadow(
//                     //               color: Colors.black.withOpacity(0.15),
//                     //               spreadRadius: 1,
//                     //               blurRadius: 10,
//                     //               offset: Offset(5, 10),
//                     //             ),
//                     //           ],
//                     //           gradient: LinearGradient(colors: [
//                     //             Color(0xffF19143),
//                     //             // Color(0xffFFB238),
//                     //             Color(0xffFFB238).withOpacity(0.9),
//                     //             Color(0xffFFB238).withOpacity(0.8),
//                     //             // Color(0xffFFB238),
//                     //           ]),
//                     //         ),
//                     //         child: Row(
//                     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //           children: [
//                     //             Padding(
//                     //               padding: const EdgeInsets.only(left: 0.0),
//                     //               child: CircleAvatar(
//                     //                 radius: 33.0,
//                     //                 // backgroundColor: Colors.white,
//                     //                 backgroundColor: Colors.transparent,
//                     //                 child: Image.asset(
//                     //                   "images/lock2.png",
//                     //                   height: size.height * 0.2,
//                     //                   width: size.width * 0.3,
//                     //                 ),
//                     //               ),
//                     //             ),
//                     //             // Container(
//                     //             //   margin: EdgeInsets.all(10.0),
//                     //             //   child: Container(
//                     //             //     child: SizedBox(
//                     //             //       width: 10.0,
//                     //             //     ),
//                     //             //   ),
//                     //             // ),
//                     //             Padding(
//                     //               padding: const EdgeInsets.only(
//                     //                 top: 20.0,
//                     //                 bottom: 20.0,
//                     //                 right: 10.0,
//                     //               ),
//                     //               child: Column(
//                     //                 crossAxisAlignment:
//                     //                     CrossAxisAlignment.start,
//                     //                 children: [
//                     //                   Text(
//                     //                     "${data[index][0]["website"].toUpperCase()}",
//                     //                     style: TextStyle(
//                     //                       fontSize: 25.0,
//                     //                       color: Colors.black,
//                     //                       fontFamily: "Montserrat",
//                     //                     ),
//                     //                   ),
//                     //                   //   Text(
//                     //                   //     "${data[index][0]["password"]}",
//                     //                   //     style: TextStyle(
//                     //                   //       fontSize: 16.0,
//                     //                   //       color: Colors.white,
//                     //                   //       fontFamily: "Montserrat",
//                     //                   //     ),
//                     //                   //   ),
//                     //                 ],
//                     //               ),
//                     //             ),
//                     //             IconButton(
//                     //               onPressed: () {
//                     //                 Clipboard.setData(
//                     //                   ClipboardData(
//                     //                     text: data[index][0]["password"],
//                     //                   ),
//                     //                 );
//                     //               },
//                     //               icon: Icon(
//                     //                 Icons.copy,
//                     //                 color: Colors.black,
//                     //               ),
//                     //             ),
//                     //           ],
//                     //         ),
//                     //       ),
//                     //     );
//                     //   },
//                     // );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       //   ],
//       // ),
//     );
//   }
// }
