import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

import 'package:copper_fox/exports.dart';

// import 'package:copper_fox/views/auth_vm.dart';
import 'package:copper_fox/services/weather_service.dart';

void main() {
  test("Testing tokyo weather", () async {
    // GetIt.I.registerLazySingleton(() => WeatherService());
    WeatherService service = WeatherService();

    service.weatherOutput.listen((event) {
      Weather w = event["current"];
      List<Weather> fdw = event["fiveDays"];

      print(w.areaName);
      fdw.forEach((element) {
        print(element.date);
        print(element.weatherMain);
      });
      expect(w, TypeMatcher<Weather>());
      expect(fdw, TypeMatcher<List<Weather>>());
    });

    await service.getCityWeather(WeatherService.tokyoCityName);
  });

  test("Testing New York weather", () async {
    // GetIt.I.registerLazySingleton(() => WeatherService());
    WeatherService service = WeatherService();

    service.weatherOutput.listen((event) {
      Weather w = event["current"];
      List<Weather> fdw = event["fiveDays"];

      print(w.areaName);
      fdw.forEach((element) {
        print(element.date);
        print(element.weatherIcon);

        print(element.weatherMain);
      });
      expect(w, TypeMatcher<Weather>());
      expect(fdw, TypeMatcher<List<Weather>>());
    });

    await service.getCityWeather(WeatherService.newYorkCityName);
  });
}
