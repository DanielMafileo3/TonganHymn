import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:tonganhymn/Models/appthemes.dart';
import 'package:tonganhymn/Screens/starterpage.dart';

import 'Models/datasearch.dart';

//void main() => runApp(MyApp());

List hymnHistory = [];
const MaterialColor whitet = const MaterialColor(0xFFFFFFFF, const <int, Color>{
  50: const Color(0xFFFFFFFF),
  100: const Color(0xFFFFFFFF),
  200: const Color(0xFFFFFFFF),
  300: const Color(0xFFFFFFFF),
  400: const Color(0xFFFFFFFF),
  500: const Color(0xFFFFFFFF),
  600: const Color(0xFFFFFFFF),
  700: const Color(0xFFFFFFFF),
  800: const Color(0xFFFFFFFF),
  900: const Color(0xFFFFFFFF)
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  // await DB.init();
  runApp(MyApp());
  DataSearch();

  ///TodoHelper();
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //var whitet;
    return DynamicTheme(
        themeCollection: themeCollection,
        defaultThemeId: AppThemes.lightDay,
        builder: (context, theme) {
          return MaterialApp(
            title: 'STT',
            theme: theme,
            home: StarterPage(),
          );
        });
  }
}
