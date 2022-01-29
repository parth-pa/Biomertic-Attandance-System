import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String title, hint;

  final TextEditingController controller;
  final Icon icon;

  const Textfield({
    Key? key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 16, offset: Offset(0, 2))
          ]),
      height: 60,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style:const TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: icon,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black38, letterSpacing: 1.5)),
      ),
    ));
  }
}
