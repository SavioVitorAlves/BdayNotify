/*import 'package:bdaynotify/main.dart';
import 'package:bdaynotify/services/custom_local_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CustomFirebaseMessaging {
  final CustomLocalNotification _customLocalNotification;
  
  CustomFirebaseMessaging._internal(this._customLocalNotification);
  static final CustomFirebaseMessaging _singleton = 
    CustomFirebaseMessaging._internal(CustomLocalNotification());
  factory CustomFirebaseMessaging() => _singleton;

  Future<void> initialize()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(badge: true,sound: true, alert: true);

    FirebaseMessaging.onMessage.listen((mensagem){
      RemoteNotification? notification = mensagem.notification;
      AndroidNotification? android = mensagem.notification?.android;
      if (notification != null && android != null) {
        _customLocalNotification.androidNotification(notification, android);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((mensagem){
      if (mensagem.data['goTO'] != null) {
        navigatorKey.currentState?.pushNamed(mensagem.data['goTO']);
      }
    });
  }
  getTokenFirebase() async => debugPrint(await FirebaseMessaging.instance.getToken());
}*/

