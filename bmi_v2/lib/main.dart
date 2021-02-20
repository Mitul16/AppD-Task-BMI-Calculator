import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'home_page.dart';
import 'globals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  getAppDirPath().then((path) {
    appDirPath = path;
    runApp(MyApp());
  });
}

Future<String> getAppDirPath() async {
  return (await getApplicationSupportDirectory()).path;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Color(0xffffffff),
        backgroundColor: Color(0x2f000000),
        primaryColor: Colors.lightGreen,
        accentColor: Colors.amber,
        splashColor: Colors.black38,
        shadowColor: Colors.transparent,
        sliderTheme: SliderThemeData(
          activeTrackColor: Color(0xff000000),
          inactiveTrackColor: Color(0xff7f7f7f),
          overlayColor: Colors.black38,
          thumbColor: Colors.amber,
          trackHeight: 2,
        ),
        iconTheme: Theme.of(context).iconTheme
            .copyWith(color: Colors.black),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primaryTextTheme: Theme.of(context).primaryTextTheme
            .apply(
          bodyColor: Colors.white,
          fontFamily: 'Comfortaa',
        ),
        textTheme: Theme.of(context).textTheme
            .apply(bodyColor: Colors.black),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Color(0xff000000),
        backgroundColor: Color(0x2fffffff),
        primaryColor: Colors.lightGreen,
        accentColor: Colors.amber,
        splashColor: Colors.white38,
        shadowColor: Colors.transparent,
        sliderTheme: SliderThemeData(
          activeTrackColor: Color(0xffffffff),
          inactiveTrackColor: Color(0xff7f7f7f),
          overlayColor: Colors.white38,
          thumbColor: Colors.amber,
          trackHeight: 2,
        ),
        iconTheme: Theme.of(context).iconTheme
            .copyWith(color: Colors.white),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primaryTextTheme: Theme.of(context).primaryTextTheme
            .apply(
          bodyColor: Colors.white,
          fontFamily: 'Comfortaa',
        ),
        textTheme: Theme.of(context).textTheme
            .apply(bodyColor: Colors.white),
      ),
      home: HomePage(),
    );
  }
}
