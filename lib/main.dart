import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_demo/Services/notification_services.dart';

Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
 NotificationServices.createNewNotification(message);
  log("its a background message ${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);

  String? token = await FirebaseMessaging.instance.getToken();
  print(token);
  NotificationServices.initializeLocalNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // void getIntialMessage() async {
  //   RemoteMessage? message =
  //       await FirebaseMessaging.instance.getInitialMessage();
  //   // NotificationServices.createNewNotification(message!);
  //   log("its a initial message$message");
  // }

  @override
  void initState() {
    super.initState();

 FirebaseMessaging.onMessage.listen((message) {
      NotificationServices.createNewNotification(message);
      log("onmessage message received! ${message.data}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationServices.createNewNotification(message);
      log("onMessageOpenedApp message received! ${message.data}");
    });
    // getIntialMessage();
    //sdfg
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification Demo"),
      ),
      body: const Center(
        child: Text("Firebase Push Notification"),
      ),
    );
  }
}
