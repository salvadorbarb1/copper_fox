import 'package:copper_fox/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuScreen extends StatelessWidget {
  final controller;
  const MenuScreen({this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("MENU");
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                GetIt.I<MainLogic>().currentLocationSelected();
                controller.toggle();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 20,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Mi ubicación',
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                GetIt.I<MainLogic>().newYorkSelected();
                controller.toggle();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 20,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nueva York',
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                GetIt.I<MainLogic>().tokyoSelected();
                controller.toggle();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 20,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Tokio',
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
