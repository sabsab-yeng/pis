import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pis/models/job.dart';
import 'package:pis/services/job_service.dart';
import 'package:pis/ui/screens/job/job_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _anchorToBottom = false;
  // instance of util class
  JobApiService databaseUtil;
  FirebaseMessaging messaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    //Get the job from database
    // db.getAllJobs().then((employee) {
    //   setState(() {
    //     employee.forEach((employees) {
    //       items.add(Job.fromMap(employees));
    //     });
    //   });
    // });
    databaseUtil = JobApiService();
    databaseUtil.initState();

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
      body: FirebaseAnimatedList(
        key: ValueKey<bool>(_anchorToBottom),
        query: databaseUtil.getJob(),
        reverse: _anchorToBottom,
        sort: _anchorToBottom
            ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
            : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return SizeTransition(
            sizeFactor: animation,
            child: showjob(snapshot),
          );
        },
      ),
    );
  }

  Widget showjob(DataSnapshot res) {
    JobOrder job = JobOrder.fromSnapshot(res);

    var item = Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JobDetialPage(
                        id: job.id,
                        dateInstall: job.dateInstall,
                        status: job.status,
                      )));
        },
        child: Container(
            child: Center(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    child: Text(getShortName(job)),
                    backgroundColor: const Color(0xFF20283e),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            job.empid,
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.lightBlueAccent),
                          ),
                          Text(
                            job.dateInstall,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.amber),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              job.status,
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.green),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
      ),
    );

    return item;
  }

  String getShortName(JobOrder job) {
    String shortName = "";
    if (job.status.isNotEmpty) {
      shortName = job.status.substring(0, 1);
    }
    return shortName;
  }
}
