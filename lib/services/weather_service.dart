// 3f2e75a48ce14dcf6705e92e944b4c1e
import 'package:copper_fox/exports.dart';

class WeatherService {
  static const String _key = "3f2e75a48ce14dcf6705e92e944b4c1e";
  static const String newYorkCityName = "New York";
  static const String tokyoCityName = "Tokyo";

  late LocationData _locationData;
  late WeatherFactory _wf;

  StreamController<Map<String, dynamic>> _weatherController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get weatherOutput =>
      _weatherController.stream.asBroadcastStream();

  WeatherService() {
    initializeService();
  }
  initializeService() {
    _wf = WeatherFactory(_key, language: Language.SPANISH);
  }

  Future getCurrentLocationWeather() async {
    // print("CURRENT");
    await _getCurrentLocation();

    _wf.language = Language.SPANISH;

    Map<String, dynamic> weatherMap = {
      "current": await _wf.currentWeatherByLocation(
          _locationData.latitude!, _locationData.longitude!),
      "fiveDays": await _wf.fiveDayForecastByLocation(
          _locationData.latitude!, _locationData.longitude!)
    };
    _weatherController.sink.add(weatherMap);

    return;
  }

  Future getCityWeather(String cityName) async {
    _wf.language = Language.SPANISH;

    Map<String, dynamic> weatherMap = {
      "current": await _wf.currentWeatherByCityName(cityName),
      "fiveDays": await _wf.fiveDayForecastByCityName(cityName)
    };
    _weatherController.sink.add(weatherMap);
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

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
