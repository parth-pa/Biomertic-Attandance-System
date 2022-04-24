import 'package:flutter/material.dart';
import '../Widgets/intro_card.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Choose your Role',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: 1.5),
              ),
            ],
          ),
          CardFb1(
              text: 'Admin',
              imageUrl: 'assets/admin.png',
              onPressed: () {
                Navigator.pushNamed(context, '/adminsignup');
              }),
          CardFb1(
              text: 'Employe',
              imageUrl: 'assets/employe.png',
              onPressed: () {
                Navigator.pushNamed(context, '/employe');
              }),
        ],
      ),
    );
  }
}
