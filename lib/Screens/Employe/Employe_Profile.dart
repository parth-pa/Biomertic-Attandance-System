import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class employedata extends StatefulWidget {
  employedata({Key? key}) : super(key: key);

  @override
  State<employedata> createState() => _employedataState();
}

class _employedataState extends State<employedata> {
  SharedPreferences? logout;
  String fname = "";
  String lname = "";
  String email = "";
  String address = "";
  String city = "";
  String phone = "";
  String date = "";

  void getdata() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      fname = pref.getString('fname')!;
      lname = pref.getString('lname')!;
      email = pref.getString('email')!;
      address = pref.getString('address')!;
      city = pref.getString('city')!;
      phone = pref.getString('phone')!;
      date = pref.getString('date')!;
    });
  }

  CollectionReference users = FirebaseFirestore.instance.collection('admin');

  savedatatoadminpanle() {
    users.add({'firstname': fname, 'email': date, 'lastname': lname}).then(
        (value) => print('save'));
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
      Fluttertoast.showToast(
          msg: "Attandance Sucess",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushNamed(context, '/1');
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/intro');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'profile'.toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        leadingWidth: 90,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
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
                    fname,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    lname,
                    style: const TextStyle(
                      letterSpacing: 1,
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
                        color: Colors.purple,
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
                height: 20,
              ),
              ListTile(
                title: const Textlable(title: 'Email'),
                subtitle: Textvalue(title: date),
              ),
              ListTile(
                title: const Textlable(title: 'Date Of Birth'),
                subtitle: Textvalue(title: email),
              ),
              ListTile(
                title: const Textlable(title: 'Phonenumber'),
                subtitle: Textvalue(title: phone),
              ),
              ListTile(
                title: const Textlable(title: 'City'),
                subtitle: Textvalue(title: city),
              ),
              ListTile(
                title: const Textlable(title: 'Address'),
                subtitle: Textvalue(title: address),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _authenticateWithBiometrics();
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                      child: Text(
                    'Give Attandance ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
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
