import 'package:attandance_system/Widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  String myemail = "l";
  String mylast = 'l';
  String mycity = 'l';
  String myadd = 'l';
  String myphone = 'l';
  String myfirst = 'l';

  CollectionReference users = FirebaseFirestore.instance.collection('admin');

  savedatatoadminpanle() {
    users.add({'firstname': myfirst, 'city': mycity}).then(
        (value) => print('save'));
  }

  featch() async {
    var fuser = FirebaseAuth.instance.currentUser;
    if (fuser != null) {
      FirebaseFirestore.instance
          .collection('EmployeDetails')
          .doc(fuser.uid)
          .get()
          .then((value) {
        setState(() {
          myfirst = value.data()!['firstname'];
          mylast = value.data()!['lastname'];
          myphone = value.data()!['phonenumber'];
          myadd = value.data()!['address'];
          mycity = value.data()!['city'];
          myemail = value.data()!['email'];
        });
      });
    }
  }

  LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticateWithBiometrics() async {
    bool _isauthenticated = false;
    try {
      _isauthenticated = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to give attandance',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
    } on PlatformException catch (e) {
      print(e.message);
    }
    if (_isauthenticated) {
      savedatatoadminpanle();
      Navigator.pushNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: featch(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            return ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFF4B39EF),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/employe.png',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          myfirst,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          mylast,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            'IT Department ',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF95A1AC),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 2,
                      indent: 16,
                      endIndent: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Textlable(title: 'Email'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Textvalue(title: myemail),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Textlable(title: 'Date Of Birth'),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 10),
                      child: Textvalue(title: '03-04-02'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Textlable(title: 'Phonenumber'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Textvalue(title: myphone),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Textlable(title: 'City'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Textvalue(title: mycity),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Textlable(title: 'Adress'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Textvalue(title: myadd),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      _authenticateWithBiometrics();
                    },
                    child: Text('Give Attandance'))
              ],
            );
          }),
    );
  }
}

class Textlable extends StatelessWidget {
  final String title;

  const Textlable({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          letterSpacing: 1),
    );
  }
}

class Textvalue extends StatelessWidget {
  final String title;

  const Textvalue({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.normal,
          fontSize: 15,
          letterSpacing: 1),
    );
  }
}
