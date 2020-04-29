import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "Helloworld";
  
  FirebaseMessaging messaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    var android = AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = IOSInitializationSettings();

    var platform = InitializationSettings(android, ios);

    flutterLocalNotificationsPlugin.initialize(platform);

    //Intergrate with firebase
    messaging.configure(
        //Running message
        onLaunch: (Map<String, dynamic> msg) {
      print('onLaunch called $msg');
    },

        //Stop message
        onResume: (Map<String, dynamic> msg) {
      print('onResume called $msg');
    },

        //Display message
        onMessage: (Map<String, dynamic> msg) {
      showNotificationMessage(msg);

      print('onMessage called $msg');
    });

    messaging.requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      alert: true,
      badge: true,
    ));

    //Register Notification console
    messaging.onIosSettingsRegistered.listen((IosNotificationSettings setting) {
      print('IOS setting registered');
    });

    messaging.getToken().then((token) {
      update(token);
    });
  }

  update(String token) {
    print(token);
    title = token;
    setState(() {});
  }

  //Display Notification
  showNotificationMessage(Map<String, dynamic> msg) async {
    print("showNotificationMessage $msg");
    //{notification: {title: New Job near you Created, body: 1001}, data: {my_another_key: 1001, my_key: new job}}
    if (msg['notification'] != null) {
      var android = AndroidNotificationDetails('Id', 'Name', 'Description',
          importance: Importance.Max, priority: Priority.High);
      var iOS = IOSNotificationDetails();
      var platForm = NotificationDetails(android, iOS);

      String title = msg['notification']['title'];
      String body = msg['notification']['body'];

      await flutterLocalNotificationsPlugin.show(0, title, body, platForm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(title),
      ),
    );
  }
}
