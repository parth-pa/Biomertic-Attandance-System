import 'package:attandance_system/Screens/Admin/Admin_signup.dart';
import 'package:attandance_system/Screens/Employe/Employe_screen.dart';
import 'package:attandance_system/Screens/Admin/adminscreen.dart';
import 'package:attandance_system/Screens/Employe/Employe_Profile.dart';
import 'package:attandance_system/Screens/Intro_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/intro',
      routes: {
        '/admin': (context) => Admin_Screen(),
        '/intro': (context) => Intro(),
        '/adminsignup': (context) => Admin_signup(),
        '/employe': (context) => employe_screen(),
        '/1': (context) => employedata(),

        // '/': (context) => UserInformation(),
      },
    );
  }
}
