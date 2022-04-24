import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  final TextInputType keyboardtype;
  const Textfield({
    Key? key,
    required this.controller,
    required this.hint,
    required this.keyboardtype,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          bottom: 5,
        ),
        child: Text(hint,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 15,
                color: Colors.black.withOpacity(0.7))),
      ),
      subtitle: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.grey[200]),
        child: TextFormField(
          obscureText: false,
          validator: (value) {
            if (value!.isEmpty) {
              return '$hint Can\'t be empty';
            }
          },
          controller: controller,
          decoration: InputDecoration(
              hoverColor: Colors.black,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                left: 10,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.normal, letterSpacing: 0.5)),
        ),
      ),
    );
  }
}
