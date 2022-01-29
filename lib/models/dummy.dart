import 'package:flutter/material.dart';

class Employ_data {
  final int id;
  final String name;
  final DateTime date;
  final Icon icon;
  final String description;

  Employ_data(
      {required this.id,
      required this.icon,
      required this.name,
      required this.date,
      required this.description});
}

List<Employ_data> employdata = [
  Employ_data(
      id: 1,
      name: 'Parth',
      date: DateTime.now(),
      icon: Icon(Icons.add_a_photo),
      description:
          'Hello Every ONe My name is patel parth manishbhai and i am studdy in Ldrp itr'),
  Employ_data(
      id: 2,
      name: 'Dhruv',
      date: DateTime.now(),
      icon: Icon(Icons.map),
      description:
          'Hello Every ONe My name is patel parth manishbhai and i am studdy in Ldrp itr'),
  Employ_data(
      id: 3,
      name: 'Naresh',
      icon: Icon(Icons.mail),
      date: DateTime.now(),
      description:
          'Hello Every ONe My name is patel parth manishbhai and i am studdy in Ldrp itr'),
  Employ_data(
      id: 4,
      name: 'Dhruv',
      date: DateTime.now(),
      icon: Icon(Icons.map),
      description:
          'Hello Every ONe My name is patel parth manishbhai and i am studdy in Ldrp itr'),
  Employ_data(
      id: 5,
      name: 'Dhruv',
      date: DateTime.now(),
      icon: Icon(Icons.map),
      description:
          'Hello Every ONe My name is patel parth manishbhai and i am studdy in Ldrp itr'),
  Employ_data(
      id: 6,
      name: 'Dhruv',
      date: DateTime.now(),
      icon: Icon(Icons.map),
      description:
          'Hello Every ONe My name is patel parth manishbhai and i am studdy in Ldrp itr'),
  Employ_data(
      id: 7,
      name: 'Dhruv',
      date: DateTime.now(),
      icon: Icon(Icons.map),
      description:
          'Hello Every ONe My name is patel parth manishbhai and i am studdy in Ldrp itr'),
];
