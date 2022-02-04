import 'package:attandance_system/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Admin_signup extends StatefulWidget {
  const Admin_signup({Key? key}) : super(key: key);

  @override
  State<Admin_signup> createState() => _Admin_signupState();
}

// ignore: camel_case_types
class _Admin_signupState extends State<Admin_signup> {
  bool isvisible = false;
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

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
              height: 60,
            ),
            Form(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email can not be empty';
                      }
                    },
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  child: TextFormField(
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
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button('Sign Up', () {
                      Navigator.pushNamed(context, '/admin');
                    }),
                  ],
                )
              ],
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
