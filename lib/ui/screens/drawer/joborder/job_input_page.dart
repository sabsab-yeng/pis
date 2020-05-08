import 'package:flutter/material.dart';
import 'package:pis/ui/screens/drawer/joborder/job_data_helper.dart';
import '../../../ui_constant.dart';
import 'job_model.dart';

class JobInfoPage extends StatefulWidget {
  final Job job;
  JobInfoPage(this.job);

  @override
  State<StatefulWidget> createState() => _JobInfoPageState();
}

class _JobInfoPageState extends State<JobInfoPage> {
  JobDatabaseHelper db = JobDatabaseHelper();

  TextEditingController _cController;
  TextEditingController _eController;
  TextEditingController _nController;
  TextEditingController _iController;
  TextEditingController _sController;
  TextEditingController _dController;

  @override
  void initState() {
    super.initState();
    _cController = TextEditingController(text: widget.job.custid);
    _eController = TextEditingController(text: widget.job.empid);
    _nController = TextEditingController(text: widget.job.datenow);
    _iController = TextEditingController(text: widget.job.dateinstall);
    _sController = TextEditingController(text: widget.job.status);
    _dController = TextEditingController(text: widget.job.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee Info',
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
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              TextField(
                controller: _cController,
                decoration: InputDecoration(labelText: 'Customer ID'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _eController,
                decoration: InputDecoration(labelText: 'Employee ID'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _nController,
                decoration: InputDecoration(labelText: 'Date now'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _iController,
                decoration: InputDecoration(labelText: 'Date install'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _sController,
                decoration: InputDecoration(labelText: 'Status'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _dController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              RaisedButton(
                child: (widget.job.id != null) ? Text('Update') : Text('Add'),
                onPressed: () {
                  if (widget.job.id != null) {
                    db
                        .updateJob(Job.fromMap({
                      'id': widget.job.id,
                      'custid': _cController.text,
                      'empid': _eController.text,
                      'datanow': _nController.text,
                      'dateinstall': _iController.text,
                      'status': _sController.text,
                      'description': _dController.text,
                    }))
                        .then((_) {
                      Navigator.pop(context, 'update');
                    });
                  } else {
                    db
                        .saveJob(
                      Job(
                        _cController.text,
                        _eController.text,
                        _nController.text,
                        _iController.text,
                        _sController.text,
                        _dController.text,
                      ),
                    )
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
