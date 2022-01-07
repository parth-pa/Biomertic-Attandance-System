import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  void _togglePassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInLeft(
               duration: Duration(milliseconds: 1200),
               from: 80,
               child: Lottie.asset('assets/login.json',
               reverse: true),
             ),
              SizedBox(height: 10,),
              FadeInLeft(
                from: 100,
                duration: Duration(milliseconds: 1200),
                child: const Text(
                  'Log In',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FadeInLeft(
                from: 120,
                duration:  Duration(milliseconds: 1200),
                child: buildEmail(),),

              const SizedBox(
                height: 20,
              ),
             FadeInLeft(
                 from: 120,
                 duration:  Duration(milliseconds: 1200),
                 child:  buildPassword()),
              const SizedBox(
                height: 40,
              ),
              FadeInLeft(
                  from: 140,
                  duration:  Duration(milliseconds: 1200),
                  child:  LoginButton()),

            ],
          ),
        ),
      ),
    );


  }

  Widget LoginButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignIn(),
          ),
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.amber,
              blurRadius: 16,
              offset: Offset(0, 2),
            )
          ],
        ),
        child:const  Center(
          child:Text(
            'Login',
            style: TextStyle(
              letterSpacing: 2,
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPassword() {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Password',
            style: TextStyle(
                letterSpacing: 1.5,
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 16,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              obscureText: _isHidden,
              keyboardType: TextInputType.visiblePassword,
              style: const TextStyle(
                color: Colors.black87,
              ),
              decoration: const InputDecoration(
                  border: InputBorder.none,

                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: InkWell(

                    child: const Icon(Icons.visibility),

                  ),
                  hintText: 'Password',
                  hintStyle:
                      TextStyle(color: Colors.black38, letterSpacing: 1.5)),
            ),
          )
        ],
      ),
    );
  }



  Widget buildEmail() {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(
                letterSpacing: 2,
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 16,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: const TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  hintStyle:
                      TextStyle(color: Colors.black38, letterSpacing: 1.5)),
            ),
          )
        ],
      ),
    );
  }
}
