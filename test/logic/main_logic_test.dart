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
  test("Testing service instance", () async {
    GetIt.I.registerLazySingleton(() => WeatherService());
    MainLogic _logic = MainLogic();

    _logic.weatherOutput.listen((event) {
      expect(event, TypeMatcher<WeatherDataModel>());
    });

    await _logic.newYorkSelected();
  });
}
