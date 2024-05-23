

import 'package:geolocator/geolocator.dart';
class locationController  {
  // final Bool _isLoading = true.obs;
   double _latitude = 0.0;
  final double _longitude = 0.0;

  // RxBool checkLoading() => _isLoading;
  // RxDouble getLatittude() => _latittude;
  // RxDouble getLongitude() => _longitude;


  getPermission() async {
    bool isEnabled;
    LocationPermission locationPermission;
    isEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isEnabled) {
      return Future.error("Location not enabled");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location not enabled");
      }
    }





  }
}
