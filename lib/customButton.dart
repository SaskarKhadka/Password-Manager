import 'package:flutter/material.dart';
import 'package:password_manager/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final Widget buttonContent;

  const CustomButton({
    required this.onPressed,
    required this.width,
    required this.buttonContent,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      width: this.width,
      decoration: BoxDecoration(
        // color: Color(0xffe9c46a),
        borderRadius: BorderRadius.circular(30.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0xfff4a261).withOpacity(0.1),
        //     spreadRadius: 8,
        //     blurRadius: 12,
        //   ),
        // ],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(5, 10),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Color(0xffFFB238),
            Color(0xffF19143),
          ],
        ),
        // color: Colors.white,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Center(
          child: buttonContent,
        ),
      ),
    );
  }
}
