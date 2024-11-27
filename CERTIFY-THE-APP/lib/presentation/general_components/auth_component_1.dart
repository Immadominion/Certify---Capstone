import 'package:flutter/material.dart';

Widget component1(
  IconData icon,
  String hintText,
  bool isPassword,
  bool isEmail,
  BuildContext context,
  TextEditingController controller,
) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.width / 8,
    width: size.width / 1.22,
    alignment: Alignment.center,
    padding: EdgeInsets.only(right: size.width / 30),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(.05),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      style: TextStyle(color: Colors.black.withOpacity(.8)),
      obscureText: isPassword,
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black.withOpacity(.7),
        ),
        border: InputBorder.none,
        hintMaxLines: 1,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.black.withOpacity(.5),
          fontFamily: "Int",
        ),
      ),
    ),
  );
}
