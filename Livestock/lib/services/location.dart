import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  // Position? position;


  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
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


// void navigateToCurrentPosition()
// {
//   _determinePosition().then((value)async {
//     debugPrint('My current location');
//     debugPrint(value.latitude.toString() + value.longitude.toString());
//
//     _marker.add(Marker(
//         markerId: MarkerId("10"),
//         position: LatLng(value.latitude,value.longitude),
//         infoWindow: InfoWindow(
//           title: 'My current location',
//
//         )));
//
//     CameraPosition cameraPosition = CameraPosition(
//       target:  LatLng(value.latitude,value.longitude),
//       zoom: 14,
//     );
//
//     final GoogleMapController controller = await  mapController.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//     setState(() {
//
//     });
//
//   });
// }

//
// Future<void> getCurrentLocation() async {
//   try {
//
//
//     latitude = position!.latitude;
//     longitude = position!.longitude;
//   } catch (e) {
//     print(e);
//   }
// }
}