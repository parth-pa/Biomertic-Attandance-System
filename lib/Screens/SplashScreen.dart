import 'package:flutter/material.dart';

import 'LoginPage.dart';



class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading:const Icon(Icons.next_plan),

      ),
      body: Center(
        child: TextButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginPage()),);
          }, child:const Text('Go to..'),
        ),
      ),
    );
  }
}
