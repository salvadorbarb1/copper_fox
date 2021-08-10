import 'package:copper_fox/screens/city_screen.dart';
import 'package:copper_fox/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ControlScreen extends StatefulWidget {
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final draweController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    print("BUILDING");
    return Scaffold(
      body: ZoomDrawer(
        controller: draweController,
        style: DrawerStyle.Style1,
        menuScreen: MenuScreen(
          controller: draweController,
        ),
        mainScreen: CityScreen(
          zoomDrawerController: draweController,
        ),
        borderRadius: 24.0,
        disableGesture: true,
        showShadow: true,
        angle: -12.0,
        // angle: 9.0,
        backgroundColor: Colors.black12,
        slideWidth: MediaQuery.of(context).size.width * .55,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}
