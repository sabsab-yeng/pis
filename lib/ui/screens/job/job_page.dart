import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pis/models/job.dart';
import 'package:pis/ui/screens/job/job_detial_page.dart';

import '../../ui_constant.dart';
import 'add_job_order.dart';

class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

final jobsReference = FirebaseDatabase.instance.reference().child('jobOrder');

class _JobPageState extends State<JobPage> {
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
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'Jobs',
          style: appbarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: appbarIconColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                        subtitle: Column(
                          children: [
                            Text(
                              '${items[position].dateInstall}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${items[position].status}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.red),
                                ),
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.trash),
                                  onPressed: () => _deleteJob(
                                      context, items[position], position),
                                ),
                              ],
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createNewJob(context),
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

  void _deleteJob(BuildContext context, JobOrder job, int position) async {
    await jobsReference.child(job.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _createNewJob(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddJobPage(JobOrder(null, '', '', '', '', ''))),
    );
  }
}
