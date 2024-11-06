import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/screens/calendar.dart';
import 'package:bdaynotify/screens/dashboard.dart';
import 'package:bdaynotify/screens/month_detail_screem.dart';
import 'package:bdaynotify/screens/month_form.dart';
import 'package:bdaynotify/screens/splash_screen.dart';
import 'package:bdaynotify/services/custom_firebase_messaging.dart';
import 'package:bdaynotify/utils/routes_app.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
 
  // Inicialização do Firebase se você planeja usar
  // await Firebase.initializeApp();

  // Inicializar notificações
  await initializeNotifications();

  runApp(const MyApp());
}

Future<void> initializeNotifications() async {
  // Configurações específicas para Android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Configurações gerais
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  // Inicializar o plugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  
  // Defina o callback para quando a notificação for selecionada
  _configureSelectNotificationSubject();
}

// Método para configurar o callback de seleção da notificação
void _configureSelectNotificationSubject() {
  // Aqui você pode configurar um BehaviorSubject ou um método semelhante
  // para lidar com o payload quando uma notificação for selecionada
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
        routes: {
          RoutesApp.SPLASH_SCREEN: (ctx) => SplashScreen(),
          RoutesApp.HOME: (ctx) => Dashboard(),
          RoutesApp.CALENDAR: (ctx) => Calendar(),
          RoutesApp.MONTH_DETAIL: (ctx) => MonthDetailScreem(),
        },
      ),
    );
  }
}
