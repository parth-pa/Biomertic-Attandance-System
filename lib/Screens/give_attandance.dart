import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class GiveAttandance extends StatefulWidget {
  @override
  State<GiveAttandance> createState() => _GiveAttandanceState();
}

class _GiveAttandanceState extends State<GiveAttandance> {
  String fname = "";
  String lname = "";
  String department = "";
  String phone = "";

  CollectionReference users = FirebaseFirestore.instance.collection('checkin');
  CollectionReference users1 =
      FirebaseFirestore.instance.collection('checkout');

  savedatatoadminpanleforchckin() {
    users.add({
      'firstname': fname,
      'departmrent': department,
      'lastname': lname,
      'phone': phone,
      'time': Timestamp.now(),
      'Date': DateFormat('dd MMMM yyyy').format(DateTime.now()),
      'check-in': DateFormat('hh:mm a').format(DateTime.now()),
    }).then((value) => print('save'));
  }

  savedatatoadminpanleforcheckout() {
    users1.add({
      'firstname': fname,
      'departmrent': department,
      'lastname': lname,
      'phone': phone,
      'time': Timestamp.now(),
      'Date': DateFormat('dd MMMM yyyy').format(DateTime.now()),
      'check-out': DateFormat('hh:mm a').format(DateTime.now()),
    }).then((value) => print('save'));
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
      savedatatoadminpanleforchckin();
      Fluttertoast.showToast(
          msg: "Attandance Sucess At :- " +
              DateFormat('hh:mm a').format(DateTime.now()),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    }
  }

  Future<void> _authenticateWithBiometrics1() async {
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
      savedatatoadminpanleforcheckout();
      Fluttertoast.showToast(
          msg: "Attandance Sucess At :- " +
              DateFormat('hh:mm a').format(DateTime.now()),
          toastLength: Toast.LENGTH_LONG,
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
    super.initState();
    getdata();
  }

  void getdata() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      fname = pref.getString('fname')!;
      lname = pref.getString('lname')!;
      department = pref.getString('department')!;
      phone = pref.getString('phone')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hedaer(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s status',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Date  :-       ' +
                          DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          return Text(
                            'Time  :-      ' +
                                DateFormat('hh:mm  a').format(DateTime.now()),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          );
                        }),
                    const SizedBox(height: 60),
                    Builder(
                      builder: (context) {
                        final GlobalKey<SlideActionState> _key = GlobalKey();
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: SlideAction(
                            key: _key,
                            onSubmit: () {
                              _authenticateWithBiometrics();
                              Future.delayed(
                                const Duration(seconds: 2),
                                () => _key.currentState?.reset(),
                              );
                            },
                            sliderButtonIconSize: 12,
                            height: 60,
                            innerColor: Colors.white,
                            outerColor: Colors.brown,
                            sliderRotate: true,
                            borderRadius: 18,
                            elevation: 10,
                            alignment: Alignment.center,
                            child: const Text(
                              'Swipe Right  To Check In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Builder(
                      builder: (context) {
                        final GlobalKey<SlideActionState> _key = GlobalKey();
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: SlideAction(
                            key: _key,
                            onSubmit: () {
                              _authenticateWithBiometrics1();
                              Future.delayed(
                                const Duration(seconds: 2),
                                () => _key.currentState?.reset(),
                              );
                            },
                            sliderButtonIconSize: 12,
                            height: 60,
                            innerColor: Colors.white,
                            outerColor: Colors.brown,
                            sliderRotate: true,
                            borderRadius: 18,
                            elevation: 10,
                            alignment: Alignment.center,
                            child: const Text(
                              'Swipe Right  To Check Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox hedaer() {
    return SizedBox(
        height: 100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: Container(
                  width: 50,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.withOpacity(.3)),
                      child: const Icon(Icons.person),
                    ),
                  ),
                ),
                title: const Text(
                  'Welcome',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                subtitle: Text(fname + " " + lname,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ));
  }
}
