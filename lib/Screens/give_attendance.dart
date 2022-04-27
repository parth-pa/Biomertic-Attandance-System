import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
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

  var address = "";
  final R = 6372.8; // In kilometers
  double? distrance;

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
      Navigator.pop(context);
    }
  }

  Future<void> updatePosition() async {
    Position pos = await _determinePosition();

    List pa = await placemarkFromCoordinates(pos.latitude, pos.longitude);

    double curLatitude = pos.latitude;
    double curLongitude = pos.longitude;
    address = pa[0].toString();
    double clgFixLat = 23.239166;
    double clgFixLong = 72.638497;
    double dLat = _toRadians(curLatitude - clgFixLat);
    double dLon = _toRadians(curLongitude - clgFixLong);
    clgFixLat = _toRadians(clgFixLat);
    curLatitude = _toRadians(curLatitude);
    double a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) * cos(clgFixLat) * cos(curLatitude);
    double c = 2 * asin(sqrt(a));
    double finalDistanceAns = R * c;

    setState(() {
      distrance = finalDistanceAns;
    });

    // if (finalDistanceAns <= 0.9) {
    //   print('You Are in Collage');
    // } else {
    //   print("You are outside from college premise");
    //   print('You Away Frome Collage $finalDistanceAns KM ');
    // }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }

  @override
  void initState() {
    super.initState();
    getdata();
    updatePosition();
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hedaer(),
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.width * 0.4 - 20,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ]),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/employe.png',
                              ),
                              backgroundColor: Colors.white,
                              radius: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome'.toUpperCase(),
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  fname + " " + lname,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Mark Attendance',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 23,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Fast And Easy Way To Mark Atteadance',
                          style: TextStyle(
                            letterSpacing: 1.2,
                            fontSize: 15,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Builder(
                      builder: (context) {
                        final GlobalKey<SlideActionState> _key = GlobalKey();
                        return Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 40),
                          child: SlideAction(
                            key: _key,
                            onSubmit: () {
                              updatePosition();
                              Future.delayed(
                                Duration(seconds: 1),
                                () => _key.currentState!.reset(),
                              );
                              distrance! <= 0.9
                                  ? _authenticateWithBiometrics()
                                  : showDialoge(context);
                            },
                            sliderButtonIconSize: 12,
                            height: 60,
                            innerColor: Colors.white,
                            outerColor: Colors.blue.shade400,
                            sliderRotate: true,
                            borderRadius: 18,
                            elevation: 10,
                            alignment: Alignment.center,
                            child: const Text(
                              'Check In',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
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
                          padding: const EdgeInsets.only(left: 30.0, right: 40),
                          child: SlideAction(
                            key: _key,
                            onSubmit: () {
                              updatePosition();
                              Future.delayed(
                                Duration(seconds: 1),
                                () => _key.currentState!.reset(),
                              );
                              distrance! <= 0.9
                                  ? _authenticateWithBiometrics1()
                                  : showDialoge(context);
                            },
                            sliderButtonIconSize: 12,
                            height: 60,
                            innerColor: Colors.white,
                            outerColor: Colors.blue.shade400,
                            sliderRotate: true,
                            borderRadius: 18,
                            elevation: 10,
                            alignment: Alignment.center,
                            child: const Text(
                              'Check Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w900,
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

  Future<String?> showDialoge(BuildContext context) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(12, 26),
                          blurRadius: 50,
                          spreadRadius: 0,
                          color: Colors.grey.withOpacity(.1)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/73069-error.json", height: 70),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("You are outside from college premise",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(
                      height: 14,
                    ),
                    const Text("You Can Not Give Attandance  ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ));
  }

  Padding hedaer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.all(15),
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        DateFormat('dd MMMM yyyy').format(DateTime.now()),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.timer,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        DateFormat('hh : mm a').format(DateTime.now()),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
