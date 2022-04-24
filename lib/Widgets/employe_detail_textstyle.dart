import 'package:flutter/material.dart';

class Textlable extends StatelessWidget {
  final String title;

  const Textlable({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 1),
    );
  }
}

class Textvalue extends StatelessWidget {
  final String title;

  const Textvalue({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.blue[800],
          fontWeight: FontWeight.normal,
          fontSize: 13,
          letterSpacing: 1),
    );
  }
}
