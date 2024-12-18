import 'package:flutter/material.dart';

Widget component2(String string, double width, VoidCallback voidCallback,
    BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: voidCallback,
    child: Container(
      height: size.width / 8,
      width: size.width / width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        string,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: "Int",
        ),
      ),
    ),
  );
}
