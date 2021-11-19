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
        boxShadow: [
          BoxShadow(
            color: Color(0xfff4a261).withOpacity(0.1),
            spreadRadius: 8,
            blurRadius: 12,
          ),
        ],
        gradient: LinearGradient(
          colors: [
            //2nd
            // Color(0xffF6C258),
            // Color(0xffFCA33B),
            //1st
            // Color(0xffe9c46a),
            // Color(0xfff4a261),
            // 3rd
            Color(0xffFFB238),
            Color(0xffF19143),
            // Color(0xffFF773D),
          ],
        ),
        // border: Border.all(),
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
