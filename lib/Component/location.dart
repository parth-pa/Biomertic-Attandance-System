import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  var Latitude = "";
  var Longtitude = "";
  var address = "";

  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();

    List pa = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      Latitude = pos.latitude.toString();
      Longtitude = pos.longitude.toString();
      address = pa[0].toString();
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
          Text(
            "Latitude :" + Latitude,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text("Address : "),
          Text(address),
          Text("Longitude :" + Longtitude),
        ],
      ),
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          hoverColor: Colors.green,
          backgroundColor: Colors.amber,
          onPressed: () {
            _updatePosition();
          },
          child: const Icon(
            Icons.gps_fixed,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
