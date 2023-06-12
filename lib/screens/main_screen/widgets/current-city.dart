import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:geolocator/geolocator.dart';

class CurrentCity extends StatefulWidget {
  const CurrentCity({super.key});

  @override
  State<CurrentCity> createState() => _CurrentCityState();
}

class _CurrentCityState extends State<CurrentCity> {
  
  bool _serviceRequested = false;
  String? _currentAddress;
  Timer? _timer;

  @override
  void initState() {
    _getAddressFromLatLng();
    super.initState();
  } 

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_currentAddress ?? '');
  }

_startTimer() {
  _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
    _getAddressFromLatLng();
    if (_currentAddress != null) {
      timer.cancel();
    }
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

    if (context.mounted && !_serviceRequested) {
      showAlertDialog(context);
    }
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // Permissions are granted
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

  Future<void> _getAddressFromLatLng() async {
  Position _currentPosition = await _determinePosition();
  await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude)
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];
    setState(() {
      _currentAddress =
         '${place.subAdministrativeArea}';
    });
  }).catchError((e) {
    debugPrint(e);
  });
 }

 showAlertDialog(BuildContext context) {
  // Setup alert dialog action buttons
  _serviceRequested = true;
  Widget cancelButton = TextButton(
    child: const Text("No thanks!"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed:  () {
      Geolocator.openLocationSettings().then((value) {
        _startTimer();
        Navigator.pop(context);
        });
    },
  );

  // Setup the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Enable Location Service"),
    content: const Text("Would you like to continue enabling location services for better user experience?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}