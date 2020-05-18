
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pis/models/job.dart';
import 'package:pis/ui/screens/job/job_detial_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging messaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var refreshkey = GlobalKey<RefreshIndicatorState>();

  List<JobOrder> items;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  @override
  void initState() {
    super.initState();

    //Fetch Data for firebase 
      items = List();

    _onNoteAddedSubscription = jobsReference.onChildAdded.listen(_onJobAdded);
    _onNoteChangedSubscription =
        jobsReference.onChildChanged.listen(_onNoteUpdated);
   
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

  @override
  void dispose() {
    _onNoteAddedSubscription.cancel();
    _onNoteChangedSubscription.cancel();
    super.dispose();
  }


  update(String token) {
    print(token);
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
        child: ListView.builder(
          itemCount: items.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                  title: Text(
                    '${items[position].custid}',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.blue,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${items[position].dateInstall}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        '${items[position].status}',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.red),
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    radius: 15.0,
                    child: Text(
                      '${position + 1}',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => _navigateToNote(context, items[position]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onJobAdded(Event event) {
    setState(() {
      items.add(JobOrder.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue =
        items.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] =
          JobOrder.fromSnapshot(event.snapshot);
    });
  }
  void _navigateToNote(BuildContext context, JobOrder note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JobDetPage(note)),
    );
  }
}
