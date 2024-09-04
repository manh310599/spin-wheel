import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spiner_wheel/utils/routes.dart';

void main () {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        fontFamily: 'CherryBombOne',
      ),
    );
  }
}
