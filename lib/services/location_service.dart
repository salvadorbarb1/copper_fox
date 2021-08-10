import 'package:http/http.dart' as http;
import 'package:copper_fox/exports.dart';

class LocationService {
  Future<LocationData> _getCurrentLocation() async {
    // TrailPointReception reception = await _asyncSimpleDialog(mainContext);

    final LocationData locationData = await Location().getLocation();

    var globalCode;

    return locationData;
  }

  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Check whether we have permissions for the location
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // If permissions are not there, return
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // If permissions are there, find the location and store the longitude and latitude
    _locationData = await location.getLocation();
  }
}
