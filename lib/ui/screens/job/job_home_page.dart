import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pis/models/job.dart';
import 'package:pis/ui/screens/job/job_detial_page.dart';

class JobHomePage extends StatefulWidget {
  @override
  _JobHomePageState createState() => _JobHomePageState();
}

final notesReference = FirebaseDatabase.instance.reference().child('jobOrder');

class _JobHomePageState extends State<JobHomePage> {
  List<JobOrder> items;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = List();

    _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onJobAdded);
    _onNoteChangedSubscription =
        notesReference.onChildChanged.listen(_onNoteUpdated);
  }

  @override
  void dispose() {
    _onNoteAddedSubscription.cancel();
    _onNoteChangedSubscription.cancel();
    super.dispose();
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
