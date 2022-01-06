import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[300],
        bottomOpacity: 20,
        elevation: 0,
        title:const Text('hello'),
        centerTitle: true,
      ),

      body:const  Center(
        child: Text('hey user..'),
      ),
      floatingActionButton: FloatingActionButton(

        hoverColor: Colors.green,
        backgroundColor: Colors.amber,
        onPressed: (){
             Navigator.pop(context);
        },
        child:const Icon(Icons.fingerprint),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
