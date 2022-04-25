import 'package:flutter/material.dart';

class Textfield_loginForm extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  final TextInputType keyboardtype;
  const Textfield_loginForm({
    Key? key,
    required this.controller,
    required this.hint,
    required this.keyboardtype,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return '$hint Can\'t be empty';
        }
      },
      decoration: InputDecoration(
          hintText: 'Enter Your $hint',
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )),
    );
  }
}
