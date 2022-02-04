import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class employe_screen extends StatefulWidget {
  const employe_screen({Key? key}) : super(key: key);

  @override
  State<employe_screen> createState() => _employe_screenState();
}

// ignore: camel_case_types
class _employe_screenState extends State<employe_screen> {
  SharedPreferences? login;
  bool? newuser;
  final emailcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonenumercontroller = TextEditingController();
  final firstnameControler = TextEditingController();
  final lastnameControler = TextEditingController();
  final passwordcontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final dateinput = TextEditingController();

  Future<void> setdata(fname, lname, address, phone, city, email, dob) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('fname', fname);
    pref.setString('lname', lname);
    pref.setString('email', email);
    pref.setString('address', address);
    pref.setString('phone', phone);
    pref.setString('city', city);
    pref.setString('date', dob);
  }

  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/employe.png',
                      ).image,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
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
                    child: textfield(
                      controller: firstnameControler,
                      hint: 'First Name',
                      keyboardtype: TextInputType.name,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: textfield(
                    controller: lastnameControler,
                    hint: 'Last Name',
                    keyboardtype: TextInputType.name,
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: textfield(
                      controller: dateinput,
                      hint: 'Date Of Birth',
                      keyboardtype: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: textfield(
                    controller: citycontroller,
                    hint: 'City',
                    keyboardtype: TextInputType.text,
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              textfield(
                controller: emailcontroller,
                hint: 'Email',
                keyboardtype: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              textfield(
                controller: phonenumercontroller,
                hint: 'Phone No',
                keyboardtype: TextInputType.phone,
              ),
              const SizedBox(
                height: 10,
              ),
              textfield(
                controller: addresscontroller,
                hint: 'Address',
                keyboardtype: TextInputType.streetAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  login!.setBool('login', false);
                  setdata(
                      firstnameControler.text,
                      lastnameControler.text,
                      addresscontroller.text,
                      phonenumercontroller.text,
                      citycontroller.text,
                      dateinput.text,
                      emailcontroller.text);
                  Navigator.pushNamed(context, '/1');
                  if (formGlobalKey.currentState!.validate()) {
                    formGlobalKey.currentState!.save();
                    // use the email provided here
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
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

  Widget button(String title, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(.7),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        )),
      ),
    );
  }

  void check() async {
    login = await SharedPreferences.getInstance();
    newuser = (login!.getBool('login') ?? true);
    if (newuser == false) {
      Navigator.pushReplacementNamed(context, '/1');
    }
  }
}

class textfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  final TextInputType keyboardtype;
  textfield({
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
              contentPadding: EdgeInsets.only(
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
