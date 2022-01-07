

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  var Latitude = "";
  var Longtitude = "";
  var address = "";

  Future<void> _updatePosition() async{
    Position pos =await _determinePosition();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


    List pa = await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      Latitude = position.latitude.toString();
      Longtitude = position.longitude.toString();
      address = pa[0].toString();
    });
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();

  }


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

      body:Column(
        children: [
              Text("Latitude :" + Latitude),
              Text("Address : "),
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
          onPressed: (){
                _updatePosition();
          },
          child:const Icon(Icons.gps_fixed,
          size: 30,
            color: Colors.black,

          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
