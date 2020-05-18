import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pis/models/job.dart';

import '../../ui_constant.dart';

class JobDetPage extends StatefulWidget {
  final JobOrder job;
  JobDetPage(this.job);

  @override
  State<StatefulWidget> createState() => _JobDetPageState();
}

final jobsReference = FirebaseDatabase.instance.reference().child('jobOrder');

class _JobDetPageState extends State<JobDetPage> {
  TextEditingController _customerIDController;
  TextEditingController _employeeIDController;
  TextEditingController _dateNowController;
  TextEditingController _dateInstallController;
  TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _customerIDController = TextEditingController(text: widget.job.custid);
    _employeeIDController = TextEditingController(text: widget.job.empid);
    _dateNowController = TextEditingController(text: widget.job.dateNow);
    _dateInstallController =
        TextEditingController(text: widget.job.dateInstall);
    _statusController = TextEditingController(text: widget.job.status);
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
      body: SingleChildScrollView(
              child: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
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
                child: (widget.job.id != null) ? Text('Next') : Text('Add'),
                onPressed: () {
                  if (widget.job.id != null) {
                    jobsReference.child(widget.job.id).set({
                      'custId': _customerIDController.text,
                      'empId': _employeeIDController.text,
                      'dateNow': _dateNowController.text,
                      'dateInstall': _dateInstallController.text,
                      'status': _statusController.text
                    }).then((_) {
                      Navigator.pop(context);
                    });
                  } else {
                    jobsReference.push().set({
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
      ),
    );
  }
}
