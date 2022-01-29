import 'package:attandance_system/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class Admin_signin extends StatefulWidget {
  const Admin_signin({Key? key}) : super(key: key);

  @override
  State<Admin_signin> createState() => _Admin_signinState();
}

// ignore: camel_case_types
class _Admin_signinState extends State<Admin_signin> {
  bool isvisible = true;

  final passwordcontroller = TextEditingController();
  final usernameControler = TextEditingController();

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
                Container(
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
              'Sign in as a Admin',
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
                            isvisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.green,
                          ),
                        ),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button('Sign In', () {
                      Navigator.pushNamed(context, '/admin');
                    }),
                  ],
                )
              ],
            )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account ?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/adminsignup');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
