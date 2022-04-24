import 'package:attandance_system/Widgets/bottomnavbar.dart';

import '../Screens/admin_login.dart';
import '../Screens/employe_login_screeen.dart';
import '../Screens/attandance_data.dart';
import '../Screens/Intro_Page.dart';
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
        '/intro': (context) => const Intro(),
        '/adminsignup': (context) => const Admin_signup(),
        '/employe': (context) => const employe_screen(),
        '/bottomnavbar': ((context) => const bottomnavbar()),
        //'/': (context) => UserInformation(),
      },
    );
  }
}
