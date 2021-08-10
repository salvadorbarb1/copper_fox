import 'package:copper_fox/exports.dart';
import 'package:copper_fox/screens/home_screen.dart';

void main() {
  setLocators();
  runApp(const MyApp());
}

setLocators() {
  GetIt.I.registerLazySingleton(() => WeatherService());
  GetIt.I.registerLazySingleton(() => MainLogic());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ControlScreen(),
    );
  }
}
