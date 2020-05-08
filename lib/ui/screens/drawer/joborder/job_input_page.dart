import 'package:flutter/material.dart';
import 'package:pis/ui/screens/drawer/joborder/job_data_helper.dart';
import 'package:pis/ui/screens/drawer/joborder/job_model.dart';

import '../../../ui_constant.dart';

class JobInfo extends StatefulWidget {
  final Job job;
  JobInfo(this.job);

  @override
  State<StatefulWidget> createState() => _JobInfoState();
}

class _JobInfoState extends State<JobInfo> {
  JobDatabaseHelper db = JobDatabaseHelper();

  TextEditingController _custIDController;
  TextEditingController _empIDController;
  TextEditingController _dateNowController;
  TextEditingController _dateInstallController;
  TextEditingController _statusController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _custIDController = TextEditingController(text: widget.job.custid);
    _empIDController = TextEditingController(text: widget.job.empid);
    _dateNowController = TextEditingController(text: widget.job.datenow);
    _dateInstallController = TextEditingController(text: widget.job.dateInstall);
    _statusController = TextEditingController(text: widget.job.status);
    // _descriptionController =
    //     TextEditingController(text: widget.job.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Order Info',
          style: appbarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: appbarIconColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              TextField(
                controller: _custIDController,
                decoration: InputDecoration(labelText: 'Customer ID'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _empIDController,
                decoration: InputDecoration(labelText: 'Employee ID'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _dateNowController,
                decoration: InputDecoration(labelText: 'Date Now'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _dateInstallController,
                decoration: InputDecoration(labelText: 'Date Installation'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              RaisedButton(
                child: (widget.job.id != null) ? Text('Update') : Text('Add'),
                onPressed: () {
                  if (widget.job.id != null) {
                    db
                        .updateEmployee(Job.fromMap({
                      'id': widget.job.id,
                      'custid': _custIDController.text,
                      'empid': _empIDController.text,
                      'datenow': _dateNowController.text,
                      'datein': _dateInstallController.text,
                      'status': _statusController.text,
                      'description': _descriptionController.text,
                    }))
                        .then((_) {
                      Navigator.pop(context, 'update');
                    });
                  } else {
                    db
                        .saveEmployee(Job(
                      _custIDController.text,
                      _empIDController.text,
                      _dateNowController.text,
                      _dateInstallController.text,
                      _statusController.text,
                      // _descriptionController.text
                    ))
                        .then((_) {
                      Navigator.pop(context, 'save');
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
