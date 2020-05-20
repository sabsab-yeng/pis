import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pis/models/job.dart';
import 'package:pis/ui/screens/job/job_detial_page.dart';

class JobHomePage extends StatefulWidget {
  @override
  _JobHomePageState createState() => _JobHomePageState();
}

final jobsReference = FirebaseDatabase.instance.reference().child('jobOrder');

class _JobHomePageState extends State<JobHomePage> {
  List<JobOrder> items;
  StreamSubscription<Event> _onJobAddedSubscription;
  StreamSubscription<Event> _onJobChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = List();

    _onJobAddedSubscription = jobsReference.onChildAdded.listen(_onJobAdded);
    _onJobChangedSubscription =
        jobsReference.onChildChanged.listen(_onJobUpdated);
  }

  @override
  void dispose() {
    _onJobAddedSubscription.cancel();
    _onJobChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: FirebaseDatabase.instance
              .reference()
              .child("jobOrder")
              .orderByKey()
              .once(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
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
                        onTap: () => _navigateToJob(context, items[position]),
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(
                snapshot.error,
                style: TextStyle(color: Colors.red),
              );
            }
            return CircularProgressIndicator(
              backgroundColor: Colors.red,
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

  void _onJobUpdated(Event event) {
    var oldJobValue = items.singleWhere((job) => job.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldJobValue)] = JobOrder.fromSnapshot(event.snapshot);
    });
  }

  void _navigateToJob(BuildContext context, JobOrder job) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JobDetPage(job)),
    );
  }
}
