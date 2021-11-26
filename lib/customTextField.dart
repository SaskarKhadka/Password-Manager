import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/constants.dart';

//ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  String hintText;
  String labelText;
  final IconData icon;
  final bool isPassword;
  final bool isEmail;

  CustomTextField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  Random random = Random();

  @override
  void initState() {
    focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = !isFocused;
    });
  }

  String? validateWebsite(String? website) {
    if (website!.isEmpty)
      return "Required";
    else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return "Required";
    } else if (password.length < 8)
      return "Must be at least 8 characters";
    else {
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

  String _generatePassword({
    required int totalSmallLetters,
    required int totalCapLetters,
    required int totalSymbols,
    required int totalNumbers,
  }) {
    List password = [];
    for (int i = 0; i < totalSmallLetters; i++) {
      password.add(kSmallLetters[random.nextInt(26)]);
    }
    for (int i = 0; i < totalCapLetters; i++) {
      password.add(kCapitalLetters[random.nextInt(26)]);
    }
    for (int i = 0; i < totalNumbers; i++) {
      password.add(kNumbers[random.nextInt(10)]);
    }
    for (int i = 0; i < totalSymbols; i++) {
      password.add(kSymbols[random.nextInt(kSymbols.length)]);
    }
    print(password.length);
    password.shuffle();
    return password.join("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      // decoration: isFocused
      //     ? BoxDecoration(
      //         // borderRadius: BorderRadius.circular(30.0),
      //         color: Colors.white,
      //         boxShadow: [
      //           BoxShadow(
      //             color: Colors.grey.withOpacity(0.3),
      //             spreadRadius: 1,
      //             blurRadius: 10,
      //             offset: Offset(5, 10),
      //           ),
      //         ],
      //         // border: Borde,
      //       )
      //     : BoxDecoration(),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.isPassword
            ? validatePassword
            : widget.isEmail
                ? validateEmail
                : validateWebsite,
        focusNode: focusNode,
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              widget.icon,
              color: Colors.grey,
            ),
          ),
          label: Text(this.widget.labelText),
          labelStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat',
            fontSize: 15.0,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          suffix: this.widget.isPassword && isFocused
              ? Container(
                  margin: EdgeInsets.only(
                    right: 10.0,
                    // bottom: 10.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        this.widget.controller.text = _generatePassword(
                          totalSmallLetters: random.nextInt(3) + 3,
                          totalCapLetters: random.nextInt(3) + 3,
                          totalSymbols: random.nextInt(3) + 2,
                          totalNumbers: random.nextInt(3) + 2,
                        );
                      });
                      Clipboard.setData(
                          ClipboardData(text: this.widget.controller.text));
                    },
                    child: Text(
                      "GENERATE",
                      style: TextStyle(
                        color: Color(0xffFCA33B),
                        fontFamily: "Montserrat",
                        fontSize: 12.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                )
              : null,
        ),
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat',
          // color: isFocused ? Colors.black : Colors.white,
          color: Colors.white,
        ),
      ),
    );
  }
}
