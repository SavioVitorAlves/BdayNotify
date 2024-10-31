/*import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CustomLocalNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;
  CustomLocalNotification(){
    channel = const AndroidNotificationChannel(
      'high_importance-channel', 
      'High Importance Notification',
      description: 'This channer is used for important notifications.',
      importance:  Importance.max,
    );
    
    _configuraAndroid().then(
      (value){
        flutterLocalNotificationsPlugin = value;
        inicializeNotifications();
      }
    );
    

    
  }
  Future<FlutterLocalNotificationsPlugin> _configuraAndroid()async{
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      
    await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
      
    return flutterLocalNotificationsPlugin;
  }

  inicializeNotifications(){
      const android = AndroidInitializationSettings('@mipmap/ic_launcher');

      final iOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (_, __, ___, ____) {},
      );
      final IOSInitializationSettings iOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      // Coloque o código de manipulação da notificação aqui (opcional)
      },);

      flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(android: android, iOS: iOS)
      );
  }  

  androidNotification(
      RemoteNotification notification,
      AndroidNotification android,
    ){
      flutterLocalNotificationsPlugin.show(
        notification.hashCode, 
        notification.title, 
        notification.body, 
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id, 
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon

          )
        )
      );
    }
}*/