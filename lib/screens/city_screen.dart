import 'package:copper_fox/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'package:intl/intl.dart';

class CityScreen extends StatefulWidget {
  final zoomDrawerController;
  CityScreen({
    this.zoomDrawerController,
  });
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<Color> colors = [
    Color(0xffC661FF),
    Color(0xff467BFF),
  ];

  late MainLogic _logic;
  WeatherDataModel? _model;

  @override
  void initState() {
    // TODO: implement initState
    _logic = GetIt.I<MainLogic>();
    _logic.weatherOutput.listen((event) {
      _model = event;
      print(_model!.weather.areaName);
      if (_model != null) {
        cityName = _model!.weather.areaName!;
      }
      setState(() {});
    });
    _logic.currentLocationSelected();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });

    super.initState();
  }

  String cityName = "Tu ubicación";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              _model == null ? CircularProgressIndicator() : _mainListView()),
    );
  }

  _mainListView() {
    return ListView(
      children: [
        InkWell(
          onTap: () {
            widget.zoomDrawerController.toggle();
            // print(widget.zoomDrawerController);
          },
          child: Container(
            height: 50,
            width: 50,
            child: Container(
              height: 30,
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 15,
              ),
              child: SvgPicture.asset(
                'assets/icons/menu.svg',
                fit: BoxFit.fitHeight,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
        ),
        _mainDisplayColumn(),
        // _hourlyVerticalScroll(),
        _nextDaysList(),
        _detailsCoumn(),
      ],
    );
  }

  String? _formattedDate(date) {
    initializeDateFormatting();

    if (date == null) return "Sin fecha disponible";
    // var formatter = new DateFormat('HH:mm | dd/MMM/yyyy ');
    var formatter = DateFormat('dd/MM/yyyy', 'es');
    return formatter.format(date);
    // return formatted;
  }

  String _formattedHour(date) {
    if (date == null) return "Sin fecha disponible";
    var formatter = new DateFormat('HH:mm', 'es');
    // var formatter = new DateFormat('dd/MMM/yyyy ');
    return formatter.format(date);
    // return formatted;
  }

  Column _mainDisplayColumn() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 5,
            left: 20,
            right: 20,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            'Hoy',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            cityName,
            style: const TextStyle(
              height: 1.3,
              fontSize: 38,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            _formattedDate(_model!.weather.date) ?? "Sin datos",
            style: TextStyle(
              height: 1.3,
              fontSize: 14,
              color: Color(0xffBDBCE1),
            ),
          ),
        ),
        Container(
          height: 250,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/weathers/rain-cloud-sun@2x.png',
                      height: 120,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Color(0xffE4E4EE),
                  ),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: _temperatureString(
                                _model!.weather.temperature!.celsius!),
                            style: TextStyle(
                              fontFamily: 'MohrRounded',
                              fontWeight: FontWeight.w600,
                              fontSize: 68,
                              height: 0.8,
                              color: Color(0xff171717),
                            ),
                          ),
                          TextSpan(
                            text: '\n${_model!.weather.weatherDescription}',
                            style: TextStyle(
                              fontFamily: 'MohrRounded',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.8,
                              color: Color(0xffBDBCE1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffF4F4F8),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/ventos.svg',
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffF4F4F8),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/nuvem.svg',
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffF4F4F8),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/umidade.svg',
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 20,
                    width: 60,
                    child: Text(
                      '${_model!.weather.windSpeed} km/h',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 60,
                    child: Text(
                      '${_model!.weather.cloudiness}%',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 60,
                    child: Text(
                      '${_model!.weather.humidity}%',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _detailsCoumn() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 5,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            'Detalles',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          height: 180,
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: _model!.weather.humidity!,
                  appearance: CircularSliderAppearance(
                    animationEnabled: false,
                    customWidths: CustomSliderWidths(
                      handlerSize: 0,
                      trackWidth: 12,
                      progressBarWidth: 12,
                    ),
                    size: 130,
                    customColors: CustomSliderColors(
                      progressBarColors: colors,
                      trackColor: Color(0xffF4F4F8),
                      dynamicGradient: true,
                      hideShadow: true,
                    ),
                    infoProperties: InfoProperties(
                        mainLabelStyle: TextStyle(
                          letterSpacing: 0.1,
                          height: 1.0,
                          fontSize: 27,
                          fontFamily: 'MohrRounded',
                        ),
                        bottomLabelText: ('Humedad'),
                        bottomLabelStyle: TextStyle(
                          letterSpacing: 0.1,
                          height: 1.4,
                          fontSize: 14,
                          fontFamily: 'MohrRounded',
                        )),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sensación termica: ',
                          style: TextStyle(
                            fontFamily: 'MohrRounded',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 0.8,
                            color: Color(0xffBDBCE1),
                          ),
                        ),
                        TextSpan(
                          text: _temperatureString(
                              _model!.weather.tempFeelsLike!.celsius!),
                          style: TextStyle(
                            fontFamily: 'MohrRounded',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 0.8,
                            color: Color(0xff171717),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _sunsetAndSunriseColumn() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            'Sol',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          height: 240,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 5,
                ),
                child: Text(
                  '06:10',
                  style: TextStyle(
                    color: Color(0xff171717),
                    fontSize: 12,
                    height: 0,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                height: 240,
                child: Column(
                  children: [
                    Container(
                      height: 105,
                      child: Container(
                        height: 200,
                        width: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 22,
                              child: Container(
                                height: 180,
                                width: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: RDottedLineBorder.all(
                                    color: Color(0xffFCD038),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: -30,
                              child: Container(
                                height: 35,
                                width: 200,
                                child:
                                    Image.asset('assets/weathers/Sun@2x.png'),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              child: Container(
                                height: 35,
                                width: 35,
                                child: SvgPicture.asset(
                                  'assets/icons/sunrise.svg',
                                ),
                              ),
                            ),
                            Positioned(
                              top: 85,
                              child: Text(
                                'Amanecer',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xffBDBCE1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 230,
                      color: Color(0xff808080),
                    ),
                    Container(
                      height: 100,
                      child: Container(
                        height: 200,
                        width: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 6,
                              child: Container(
                                height: 180,
                                width: 178,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xffE4E4EE),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 60,
                              child: Container(
                                height: 35,
                                width: 35,
                                child: SvgPicture.asset(
                                  'assets/icons/sunset.svg',
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 85,
                              child: Text(
                                'Anochecer',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xffBDBCE1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 5,
                ),
                child: Text(
                  '18:45',
                  style: TextStyle(
                    color: Color(0xff171717),
                    fontSize: 12,
                    height: 0,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _windColumn() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            'Viento',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          height: 140,
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 30, top: 5),
                  height: 60,
                  width: 60,
                  child: SvgPicture.asset(
                    'assets/icons/vento.svg',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Dirección',
                          style: TextStyle(
                            fontFamily: 'MohrRounded',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 0.8,
                            color: Color(0xffBDBCE1),
                          ),
                        ),
                        TextSpan(
                          text: ' North',
                          style: TextStyle(
                            fontFamily: 'MohrRounded',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 0.8,
                            color: Color(0xff171717),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 35,
                      right: 35,
                    ),
                    height: 25,
                    width: 1,
                    color: Color(0xffE4E4EE),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Velocidad',
                          style: TextStyle(
                            fontFamily: 'MohrRounded',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 0.8,
                            color: Color(0xffBDBCE1),
                          ),
                        ),
                        TextSpan(
                          text: ' 12 km/h',
                          style: TextStyle(
                            fontFamily: 'MohrRounded',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 0.8,
                            color: Color(0xff171717),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _temperatureString(double celsius) {
    String degreesSign = '°';
    String temperature = celsius.toStringAsFixed(0);

    return temperature + degreesSign;
  }

  Container _nextDaysList() {
    return Container(
      height: 400,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xffF4F4F8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(55),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(55),
        ),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              'Proximos 5 días',
              style: TextStyle(
                color: Color(0xff171717),
                fontSize: 17,
              ),
            ),
          ),
          MDivider(),
          NextDayListTile(weather: _model!.day1After),
          MDivider(),
          NextDayListTile(weather: _model!.day2After),
          MDivider(),
          NextDayListTile(weather: _model!.day3After),
          MDivider(),
          NextDayListTile(weather: _model!.day4After),
          MDivider(),
          NextDayListTile(weather: _model!.day5After),
          MDivider(),
        ],
      ),
    );
  }
}

class NextDayListTile extends StatelessWidget {
  final Weather weather;

  NextDayListTile({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            child: Text(
              _formattedDate(weather.date),
              style: TextStyle(
                color: Color(0xff171717),
                fontSize: 12,
              ),
            ),
          ),
          Container(
            height: 30,
            width: 30,
            child: SvgPicture.asset(
              'assets/icons/nuvemcomsol.svg',
              color: Color(0xff83839D),
            ),
          ),
          Text(
            _minAndMaxString(),
            style: TextStyle(
              color: Color(0xff171717),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _formattedDate(date) {
    initializeDateFormatting();

    if (date == null) return "Sin fecha disponible";
    // var formatter = new DateFormat('HH:mm | dd/MMM/yyyy ');
    var formatter = DateFormat('dd/MM/yyyy', 'es');
    return formatter.format(date);
    // return formatted;
  }

  String _formattedHour(date) {
    if (date == null) return "Sin fecha disponible";
    var formatter = new DateFormat('HH:mm', 'es');
    // var formatter = new DateFormat('dd/MMM/yyyy ');
    return formatter.format(date);
    // return formatted;
  }

  _minAndMaxString() {
    String degreesSign = '°';
    String minTemperature = weather.tempMin!.celsius!.toStringAsFixed(0);
    String maxTemperature = weather.tempMax!.celsius!.toStringAsFixed(0);

    String min = minTemperature + degreesSign;
    String max = maxTemperature + degreesSign;

    return min + "/" + max;
  }
}

class MDivider extends StatelessWidget {
  const MDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: const Color(0xffE4E4EE),
    );
  }
}
