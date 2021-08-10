import 'package:copper_fox/exports.dart';

class MainLogic {
  late WeatherService _weatherService;
  late WeatherDataModel _current;
  late List<Weather> _fiveDays = [];

  StreamController<WeatherDataModel> _weatherController =
      StreamController<WeatherDataModel>.broadcast();

  Stream<WeatherDataModel> get weatherOutput =>
      _weatherController.stream.asBroadcastStream();

  MainLogic() {
    setServices();
  }

  setServices() {
    _weatherService = GetIt.I<WeatherService>();
    _weatherService.weatherOutput.listen((event) {
      Weather w = event["current"];

      List<Weather> fdw = event["fiveDays"];

      _fiveDays = _trimExtras(fdw);

      _current = WeatherDataModel(
          weather: w,
          day1After: _fiveDays[0],
          day2After: _fiveDays[1],
          day3After: _fiveDays[2],
          day4After: _fiveDays[3],
          day5After: _fiveDays[4]);

      _weatherController.sink.add(_current);
    });
  }

  List<Weather> _trimExtras(List<Weather> fdw) {
    List<Weather> onlyFiveDays = [];
    int index = 0;

    fdw.forEach((element) {
      if (index == 0 || index % 8 == 0) {
        onlyFiveDays.add(element);
      }

      index++;
    });
    return onlyFiveDays;
  }

  Future<void> currentLocationSelected() async {
    await _weatherService.getCurrentLocationWeather();
  }

  Future<void> newYorkSelected() async {
    await _weatherService.getCityWeather(WeatherService.newYorkCityName);
  }

  Future<void> tokyoSelected() async {
    await _weatherService.getCityWeather(WeatherService.tokyoCityName);
  }
}

class WeatherDataModel {
  final Weather weather;
  final Weather day1After;
  final Weather day2After;
  final Weather day3After;
  final Weather day4After;
  final Weather day5After;

  WeatherDataModel(
      {required this.weather,
      required this.day1After,
      required this.day2After,
      required this.day3After,
      required this.day4After,
      required this.day5After});
}
