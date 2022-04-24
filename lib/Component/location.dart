import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  var address = "";
  int finalDistanceAns = 0;
  final R = 6372.8; // In kilometers

  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();

    List pa = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      double curLatitude = pos.latitude;
      double curLongitude = pos.longitude;
      address = pa[0].toString();
      double clgFixLat = 23.004263;
      double clgFixLong = 71.644013;
      double dLat = _toRadians(curLatitude - clgFixLat);
      double dLon = _toRadians(curLongitude - clgFixLong);
      clgFixLat = _toRadians(clgFixLat);
      curLatitude = _toRadians(curLatitude);
      double a = pow(sin(dLat / 2), 2) +
          pow(sin(dLon / 2), 2) * cos(clgFixLat) * cos(curLatitude);
      double c = 2 * asin(sqrt(a));
      double finalDistanceAns = R * c;

      if (finalDistanceAns <= 0.9) {
        Text('Hello');
      } else {
        print("You are outside from college premise");
        print('You Away Frome Collage $finalDistanceAns KM ');
      }
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[300],
        bottomOpacity: 20,
        elevation: 0,
        title: const Text('hello'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text("Address : "),
          Text(address),
          Text('$finalDistanceAns'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.green,
        backgroundColor: Colors.amber,
        onPressed: () {
          _updatePosition();
        },
        child: const Icon(
          Icons.gps_fixed,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
