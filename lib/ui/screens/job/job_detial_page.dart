import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pis/models/job.dart';

import '../../ui_constant.dart';

class JobDetPage extends StatefulWidget {
  final JobOrder note;
  JobDetPage(this.note);

  @override
  State<StatefulWidget> createState() => _JobDetPageState();
}

final notesReference = FirebaseDatabase.instance.reference().child('jobOrder');

class _JobDetPageState extends State<JobDetPage> {
  TextEditingController _idController;
  TextEditingController _customerIDController;
  TextEditingController _employeeIDController;
  TextEditingController _dateNowController;
  TextEditingController _dateInstallController;
  TextEditingController _statusController;

  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.note.id);
    _customerIDController = TextEditingController(text: widget.note.custid);
    _employeeIDController = TextEditingController(text: widget.note.empid);
    _dateNowController = TextEditingController(text: widget.note.dateNow);
    _dateInstallController =
        TextEditingController(text: widget.note.dateInstall);
    _statusController = TextEditingController(text: widget.note.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'Job Detial',
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
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              enabled: false, 
              controller: _idController,
              decoration: InputDecoration(labelText: 'id'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              enabled: false, 
              controller: _customerIDController,
              decoration: InputDecoration(labelText: 'Customer ID'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              enabled: false, 
              controller: _employeeIDController,
              decoration: InputDecoration(labelText: 'Employee ID'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              enabled: false, 
              controller: _dateNowController,
              decoration: InputDecoration(labelText: 'Date now'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              enabled: false, 
              controller: _dateInstallController,
              decoration: InputDecoration(labelText: 'Date install'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.note.id != null) ? Text('Next') : Text('Add'),
              onPressed: () {
                if (widget.note.id != null) {
                  notesReference.child(widget.note.id).set({
                    'id': _dateInstallController.text,
                    'custId': _customerIDController.text,
                    'empId': _employeeIDController.text,
                    'dateNow': _dateNowController.text,
                    'dateInstall': _dateInstallController.text,
                    'status': _statusController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  notesReference.push().set({
                    'id': _dateInstallController.text,
                    'custId': _customerIDController.text,
                    'empId': _employeeIDController.text,
                    'dateNow': _dateNowController.text,
                    'dateInstall': _dateInstallController.text,
                    'status': _statusController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
