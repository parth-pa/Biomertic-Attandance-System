import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class employedata extends StatefulWidget {
  employedata({Key? key}) : super(key: key);

  @override
  State<employedata> createState() => _employedataState();
}

class _employedataState extends State<employedata> {
  final _auth = FirebaseAuth.instance;
  String _name = "";

  void getdata() async {
    final user = await FirebaseAuth.instance.currentUser;
    var docsnap = await FirebaseFirestore.instance
        .collection('EmployeDetails')
        .doc(user?.uid)
        .get();

    setState(() {
      _name = docsnap.data()!['firstname'];
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(_name),
        ],
      ),
    );
  }
}
