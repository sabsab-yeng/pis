import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pis/ui/screens/drawer/joborder/job_data_helper.dart';
import 'package:pis/ui/screens/drawer/joborder/job_detial_page.dart';
import 'package:pis/ui/screens/drawer/joborder/job_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Job> items = List();
  JobDatabaseHelper db = JobDatabaseHelper();

  FirebaseMessaging messaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    //Get the job from database
    db.getAllJobs().then((employee) {
      setState(() {
        employee.forEach((employees) {
          items.add(Job.fromMap(employees));
        });
      });
    });

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
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Container(
                height: 140,
                child: Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].custid}  ${items[position].empid}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${items[position].datenow}',
                            style: new TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${items[position].dateInstall}',
                                style: new TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                '${items[position].status}',
                                style: new TextStyle(
                                    fontSize: 24.0, color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 40.0,
                        child: Text(
                          '${items[position].id}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // onTap: () => _navigateToJobDetail(context, items[position]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailPage(
                              custid: "${items[position].custid}",
                              empid: "${items[position].empid}",
                              dateInstall: "${items[position].dateInstall}",
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
