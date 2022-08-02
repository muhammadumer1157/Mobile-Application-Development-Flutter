import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: Scaffold(body: LocationApp()),
  ));
}

class LocationApp extends StatefulWidget {
  LocationApp({Key? key}) : super(key: key);

  @override
  State<LocationApp> createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  bool locationFound = false;
  double fetchedLongitude = 0.0;
  double fetchedLatitude = 0.0;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    fetchLocationandStore();
    readLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Flushbar(
            backgroundColor: Colors.blueGrey,
            titleText: const Text(
              'Location',
              style: TextStyle(color: Colors.white),
            ),
            messageText: Text(
              'Longitude: $fetchedLongitude and Latitude: $fetchedLatitude',
              style: const TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 5),
          ).show(context);
        },
        child: const Text("Display Flushbar"),
      ),
    );
  }

  void fetchLocationandStore() async {
    bool permission = false;
    double latitude = 0.0;
    double longitude = 0.0;
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied ||
        checkPermission == LocationPermission.deniedForever) {
      LocationPermission requestPermission =
          await Geolocator.requestPermission();
      if (requestPermission == LocationPermission.whileInUse ||
          requestPermission == LocationPermission.always) {
        permission = true;
      }
    } else {
      permission = true;
    }
    if (permission) {
      Position currentLog = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      locationFound = true;
      latitude = currentLog.latitude;
      longitude = currentLog.longitude;
    }
    final Location = <String, dynamic>{
      'Longitude': longitude,
      'Latitude': latitude
    };

    db
        .collection("Location")
        .doc("1")
        .set(Location, SetOptions(merge: true))
        .onError((error, _) => print("Error: $error"));
  }

  void readLocation() {
    double latitude = 0.0;
    double longitude = 0.0;
    db.collection("Location").snapshots().listen(
      (event) {
        for (var doc in event.docs) {
          longitude = doc.data()["Longitude"];
          latitude = doc.data()["Latitude"];
        }
        setState(() {
          fetchedLatitude = latitude;
          fetchedLongitude = longitude;
        });
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }
}
