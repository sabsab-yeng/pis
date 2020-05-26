import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pis/models/employee.dart';
import 'package:pis/ui/widgets/assign_employee_widget.dart';

class AssignEmployeePage extends StatefulWidget {
  @override
  _AssignEmployeePageState createState() => _AssignEmployeePageState();
}

class _AssignEmployeePageState extends State<AssignEmployeePage> {
  final notesReference =
      FirebaseDatabase.instance.reference().child('employee');
  List<Employee> items = List();
  StreamSubscription<Event> _onNoteAddedSubscription;

  List<Employee> selectedList;

  @override
  void initState() {
    super.initState();
    selectedList = List();
    _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onNoteAdded);
  }

  @override
  void dispose() {
    super.dispose();
    _onNoteAddedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: FirebaseDatabase.instance
              .reference()
              .child("employee")
              .orderByKey()
              .once(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                ),
                itemCount: items.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (context, position) {
                  return AssignEmployeeWidget(
                      item: items[position],
                      isSelected: (bool value) {
                        setState(() {
                          if (value) {
                            selectedList.add(items[position]);
                          } else {
                            selectedList.remove(items[position]);
                          }
                        });
                        print("$position : $value");
                      },
                      key: Key(items[position].toString()));
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

  void _onNoteAdded(Event event) {
    setState(() {
      items.add(Employee.fromSnapshot(event.snapshot));
    });
  }
}
