import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/employe_login_tetfield.dart';

class employe_screen extends StatefulWidget {
  const employe_screen({Key? key}) : super(key: key);

  @override
  State<employe_screen> createState() => _employe_screenState();
}

// ignore: camel_case_types
class _employe_screenState extends State<employe_screen> {
  bool? newuser;
  SharedPreferences? logindata;

  void check() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata!.getBool('login') ?? true);
    if (newuser == false) {
      Navigator.pushReplacementNamed(context, '/bottomnavbar');
    }
  }

  final emailcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonenumercontroller = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordcontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final dateinput = TextEditingController();

  Future<void> setdata(fname, lname, item, email, dob, phone, address) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('fname', fname);
    pref.setString('lname', lname);
    pref.setString('email', email);
    pref.setString('address', address);
    pref.setString('phone', phone);
    pref.setString('date', dob);
    pref.setString('department', item);
  }

  CollectionReference users = FirebaseFirestore.instance.collection('admin');

  savedatatoadminpanleforchckin() {
    users.add({
      'firstname': firstnameController.text,
      'departmrent': dropdownvalue,
      'lastname': lastnameController.text,
      'phone': phonenumercontroller.text,
    }).then((value) => print('save'));
  }

  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    check();
  }

  var department = ['IT', 'MBA', 'CE', 'ME', 'EE', 'CIVIL', 'EC'];

  String? dropdownvalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 40,
            ),
            buildform(),
          ],
        ),
      ),
    );
  }

  Form buildform() {
    return Form(
        key: formGlobalKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Textfield(
                      controller: firstnameController,
                      hint: 'First Name',
                      keyboardtype: TextInputType.name,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Textfield(
                    controller: lastnameController,
                    hint: 'Last Name',
                    keyboardtype: TextInputType.name,
                  )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text('Department',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.7))),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: DropdownButton(
                    value: dropdownvalue,
                    isExpanded: true,
                    hint: const Text(
                      'Please Select Your Department',
                    ),
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: Colors.deepPurple,
                    ),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                    items: department.map((String items) {
                      return DropdownMenuItem<String>(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              letterSpacing: 0.5),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Textfield(
                controller: dateinput,
                hint: 'Date Of Birth',
                keyboardtype: TextInputType.number,
              ),
              const SizedBox(
                height: 5,
              ),
              Textfield(
                controller: emailcontroller,
                hint: 'Email',
                keyboardtype: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 5,
              ),
              Textfield(
                controller: phonenumercontroller,
                hint: 'Phone No',
                keyboardtype: TextInputType.number,
              ),
              const SizedBox(
                height: 5,
              ),
              Textfield(
                controller: addresscontroller,
                hint: 'Address',
                keyboardtype: TextInputType.streetAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  logindata!.setBool('login', false);

                  setdata(
                    firstnameController.text,
                    lastnameController.text,
                    dropdownvalue,
                    emailcontroller.text,
                    dateinput.text,
                    phonenumercontroller.text,
                    addresscontroller.text,
                  );
                  savedatatoadminpanleforchckin();
                  Navigator.pushNamed(context, '/bottomnavbar');
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(.7),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
