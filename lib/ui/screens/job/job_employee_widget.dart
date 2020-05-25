import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pis/enum/enum.dart';
import 'package:pis/models/employee.dart';

class EmployeeWidget extends StatefulWidget {
  @override
  _EmployeeWidgetState createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<EmployeeWidget> {
  
  final notesReference =
      FirebaseDatabase.instance.reference().child('employee');
  List<Employee> items = List();
  StreamSubscription<Event> _onNoteAddedSubscription;

  var isSelected = false;
  var mycolor=Colors.white;

  //When we select employee
  List<bool> _selections = [];
  List<bool> get selections => _selections;
  EmployeeChoise choise;

  List<Employee> _employee = [];
  List<Employee> get employee => _employee;

  @override
  void initState() {
    super.initState();
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
          future: FirebaseDatabase.instance.reference().child("employee").orderByKey().once(),
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
                  return Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(10, 0, 5, 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 40.0,
                          // child: Text(items[position].firstname.substring(0, 1) + "." + items[position].lastname.substring(0, 1)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${items[position].firstname}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${items[position].lastname}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
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

  void _onNoteAdded(Event event) {
    setState(() {
      items.add(Employee.fromSnapshot(event.snapshot));
    });
  }
}
