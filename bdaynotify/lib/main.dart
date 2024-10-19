import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/screens/calendar.dart';
import 'package:bdaynotify/screens/dashboard.dart';
import 'package:bdaynotify/screens/month_detail_screem.dart';
import 'package:bdaynotify/screens/month_form.dart';
import 'package:bdaynotify/utils/routes_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    

    return ChangeNotifierProvider(
      create: (_) => MonthItem(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: Dashboard(),
        routes: {
          RoutesApp.HOME: (ctx) => Dashboard(),
          RoutesApp.CALENDAR:  (ctx) => Calendar(),
          RoutesApp.MONTH_DETAIL: (ctx) => MonthDetailScreem(), 
        },
      ),
    );
  }
}

