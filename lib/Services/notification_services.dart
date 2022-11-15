import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../main.dart';




class NotificationServices{

  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
      null, //'resource://drawable/res_app_icon',//
      [
        NotificationChannel(
            channelKey: 'alerts',
            channelName: 'Alerts',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.deepPurple,
            ledColor: Colors.deepPurple)
      ],
    );

  }

 static int createUniqueId() {
   return DateTime.now().millisecondsSinceEpoch.remainder(100000);
 }


 static Future<void> createNewNotification(RemoteMessage message) async {
   await  AwesomeNotifications().createNotification(
     content: NotificationContent(
         displayOnForeground:false,
         id: createUniqueId(), // -1 is replaced by a random number
         channelKey: 'alerts',
         title: message.data["title"],
         body:
         message.data["body"],
         bigPicture: message.data["big_picture"],
         largeIcon: message.data["large_icon"],
         notificationLayout: NotificationLayout.BigPicture,
         payload: {'notificationId': '123456789'}),
   );
 }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("we get the message");
  }



}