import 'package:bdaynotify/screens/calendar.dart';
import 'package:bdaynotify/screens/dashboard.dart';
import 'package:bdaynotify/utils/routes_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: Dashboard(),
      routes: {
        RoutesApp.HOME: (ctx) => Dashboard(),
        RoutesApp.CALENDAR:  (ctx) => Calendar(), 
      },
    );
  }
}

