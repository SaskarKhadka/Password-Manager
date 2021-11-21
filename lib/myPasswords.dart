import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/database/databaseHandler.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyPasswords extends StatefulWidget {
  const MyPasswords({Key? key}) : super(key: key);

  @override
  _MyPasswordsState createState() => _MyPasswordsState();
}

class _MyPasswordsState extends State<MyPasswords> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   title: Text(
      //     "PASSWORDS",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //       fontSize: 30.0,
      //       fontFamily: "Montserrat",
      //       color: Colors.black,
      //     ),
      //   ),
      //   toolbarHeight: 60,
      //   centerTitle: true,
      //   // backgroundColor: Color(0xffFCA33B),
      //   backgroundColor: Colors.transparent,
      // ),
      // backgroundColor: Color(0xffFFB238),
      // backgroundColor: Color(0xff0d0907),
      // body: Stack(
      //   children: [
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffF19143),
            // Color(0xffFFB238),
            Color(0xffFFB238).withOpacity(0.9),
            Color(0xffFFB238).withOpacity(0.8),
          ]),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 30.0,
                bottom: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              margin: EdgeInsets.only(
                top: size.height * 0.075,
              ),
              // color: Color(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "PASSWORDS",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: "Montserrat",
                      // color: Color(0xffFCA33B),
                      color: Colors.black,
                    ),
                  ),
                  // Hero(
                  //   tag: "mainLogo",
                  //   child: Image.asset(
                  //     "images/lock2.png",
                  //     height: size.height * 0.2,
                  //     width: size.width * 0.4,
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    height: 55,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Search passwords",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              EvaIcons.search,
                              // color: Color(0xffFCA33B),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                        // focusedBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10.0),
                        //   borderSide: BorderSide(
                        //     // color: Color(0xffFCA33B),
                        //     color: Colors.black,
                        //     width: 2.0,
                        //     style: BorderStyle.none,
                        //   ),
                        // ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10.0),
                        //   borderSide: BorderSide(
                        //     // color: Color(0xffFCA33B),
                        //     color: Colors.black,
                        //     width: 1.5,
                        //     style: BorderStyle.none,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    // topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                child: ValueListenableBuilder(
                  valueListenable: DatabaseHandler.getBox.listenable(),
                  builder: (context, Box box, _) {
                    List data = box.values.toList().cast<List>();
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: 35.0,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            // Color(0xffFFB238),
                            // Color(0xffF19143),
                            margin: EdgeInsets.only(
                              bottom: 25.0,
                              left: 20.0,
                              right: 20.0,
                            ),
                            padding: EdgeInsets.only(
                              right: 10.0,
                              left: 5.0,
                            ),
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              // color: Color(0xff0d0907).withOpacity(0.9),
                              // color: Colors.white,
                              color: Color(0xffFCA33B).withOpacity(0.9),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(5, 10),
                                ),
                              ],
                              gradient: LinearGradient(colors: [
                                Color(0xffF19143),
                                // Color(0xffFFB238),
                                Color(0xffFFB238).withOpacity(0.9),
                                Color(0xffFFB238).withOpacity(0.8),
                                // Color(0xffFFB238),
                              ]),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CircleAvatar(
                                    radius: 28.0,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      "images/lock2.png",
                                      height: size.height * 0.2,
                                      width: size.width * 0.3,
                                    ),
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.all(10.0),
                                //   child: Container(
                                //     child: SizedBox(
                                //       width: 10.0,
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    right: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data[index][0]["website"].toUpperCase()}",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.black,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                      //   Text(
                                      //     "${data[index][0]["password"]}",
                                      //     style: TextStyle(
                                      //       fontSize: 16.0,
                                      //       color: Colors.white,
                                      //       fontFamily: "Montserrat",
                                      //     ),
                                      //   ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: data[index][0]["password"],
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      //   ],
      // ),
    );
  }
}
