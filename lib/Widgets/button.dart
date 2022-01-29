import 'package:flutter/material.dart';

Widget button(String title, Function() onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 40,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(.7),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
      )),
    ),
  );
}
