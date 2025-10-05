import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MessagingConfig {


  static initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
   
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      log("message recieved");
      Fluttertoast.showToast(
        msg: "${event.notification!.title}\n${event.notification!.body}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
      log(event.notification!.body.toString());
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Message clicked!');
    });
  }
 @pragma('vm:entry-point')
 static Future<void> messageHandler(RemoteMessage message) async {
  log('background message ${message.notification!.body}');
   Fluttertoast.showToast(
        msg:  "${message.notification!.title}\n${message.notification!.body}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
         backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
}
}
