import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/employe_detail_textstyle.dart';

class Employedata extends StatefulWidget {
  const Employedata({Key? key}) : super(key: key);

  @override
  State<Employedata> createState() => _EmployedataState();
}

class _EmployedataState extends State<Employedata> {
  String fname = "";
  String lname = "";
  String email = "";
  String address = "";
  String phone = "";
  String date = "";
  String department = "";

  void getdata() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      fname = pref.getString('fname')!;
      lname = pref.getString('lname')!;
      email = pref.getString('email')!;
      address = pref.getString('address')!;
      phone = pref.getString('phone')!;
      date = pref.getString('date')!;
      department = pref.getString('department')!;
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/intro');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'profile'.toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color(0xFF4B39EF),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/employe.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fname,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    lname,
                    style: const TextStyle(
                      letterSpacing: 1,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      department + '  Department',
                      style: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
                thickness: 2,
                indent: 16,
                endIndent: 16,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                title: const Textlable(title: 'Email'),
                subtitle: Textvalue(title: email),
              ),
              ListTile(
                title: const Textlable(title: 'Date Of Birth'),
                subtitle: Textvalue(title: date),
              ),
              ListTile(
                title: const Textlable(title: 'Phonenumber'),
                subtitle: Textvalue(title: phone),
              ),
              ListTile(
                title: const Textlable(title: 'Address'),
                subtitle: Textvalue(title: address),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
