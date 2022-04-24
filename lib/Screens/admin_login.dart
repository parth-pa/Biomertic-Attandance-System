import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Admin_signup extends StatefulWidget {
  const Admin_signup({Key? key}) : super(key: key);

  @override
  State<Admin_signup> createState() => _Admin_signupState();
}

// ignore: camel_case_types
class _Admin_signupState extends State<Admin_signup> {
  bool isvisible = false;

  String email = "parth.patel030402@gmail.com";
  String password = "1234";

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  Future checklogin() async {
    if (emailcontroller.text == email && passwordcontroller.text == password) {
      Navigator.pushNamed(context, '/admin');
      Fluttertoast.showToast(
          msg: "Login Succesfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Enter Valid Details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    'assets/admin.png',
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Log in as a Admin',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
                child: Container(
              margin: const EdgeInsets.all(60),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      controller: passwordcontroller,
                      obscureText: isvisible,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isvisible = !isvisible;
                              });
                            },
                            icon: Icon(
                              isvisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 6) {
                          return "password length should be atleast 6";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.orange.withOpacity(.7),
                    onPressed: () {
                      checklogin();
                    },
                    child: const Text('Log In'),
                  )
                ],
              ),
            )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
