import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pis/enum/enum.dart';
import 'package:pis/models/job.dart';
import 'package:pis/ui/screens/employee/employee_page.dart';
import 'package:pis/ui/widgets/bottom_button_widget.dart';
import 'package:pis/ui/widgets/google_map_widget.dart';
import '../../ui_constant.dart';

class JobDetPage extends StatefulWidget {
  final JobOrder job;
  JobDetPage(this.job);

  @override
  State<StatefulWidget> createState() => _JobDetPageState();
}

final jobsReference = FirebaseDatabase.instance.reference().child('jobOrder');

class _JobDetPageState extends State<JobDetPage> {
// Form key
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Text _customerIDController;
  Text _employeeIDController;
  Text _dateNowController;
  Text _dateInstallController;
  TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _customerIDController = Text(widget.job.custid);
    _employeeIDController = Text(widget.job.empid);
    _dateNowController = Text(widget.job.dateNow);
    _dateInstallController = Text(widget.job.dateInstall);
    _statusController = TextEditingController(text: widget.job.status);
  }

  //Check status
  Widget _buttonAction(JobStatus jobStatus) {
    if (jobStatus == JobStatus.New) {
      //Create the button
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "SiteSurvey",
        icon: Icon(Icons.straighten, color: Colors.white),
        onClicked: () {
          // _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
          //   return LookingEmployeeWidget();
          // });

          openEmployee(context);
        },
      );
    } else if (jobStatus == JobStatus.SiteSurvey) {
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "MaterialRequest",
        icon: Icon(Icons.straighten, color: Colors.white),
        onClicked: () {
          // _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
          //   return LookingEmployeeWidget();
          // });

          openLocation(context);
        },
      );
    } else if (jobStatus == JobStatus.InstallationExecution) {
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "Testing",
        icon: Icon(Icons.straighten, color: Colors.white),
        onClicked: () {
          // _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
          //   return LookingEmployeeWidget();
          // });

          openLocation(context);
        },
      );
    } else if (jobStatus == JobStatus.Testing) {
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "TechReport",
        icon: Icon(Icons.straighten, color: Colors.white),
        onClicked: () {
          // _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
          //   return LookingEmployeeWidget();
          // });

          openLocation(context);
        },
      );
    } else if (jobStatus == JobStatus.TechReport) {
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "CustomerConfirm",
        icon: Icon(Icons.straighten, color: Colors.white),
        onClicked: () {
          // _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
          //   return LookingEmployeeWidget();
          // });

          openLocation(context);
        },
      );
    }
    // By default returning nothing
    return Container();
  }

  openLocation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
              height: 600,
              child: FullMapWidget(onSelectedLocation: (lat, long) {})),
        );
      },
    );
  }

  openEmployee(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 600,
            child: EmployeePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(5.0)),
                Text("Customer ID: " + _customerIDController.data),
                Padding(padding: EdgeInsets.all(5.0)),
                Text("Employee ID: " + _employeeIDController.data),

                Padding(padding: EdgeInsets.all(5.0)),
                Text("Date Install: " + _dateInstallController.data),
                Padding(padding: EdgeInsets.all(5.0)),
                Text("Date Install: " + _dateNowController.data),
                Padding(padding: EdgeInsets.all(5.0)),
                TextField(
                  controller: _statusController,
                  decoration: InputDecoration(labelText: 'Status'),
                ),
                Padding(padding: EdgeInsets.all(5.0)),

                // RaisedButton(
                //   child: (widget.job.id != null) ? Text('Next') : Text('Add'),
                //   onPressed: () {
                //     if (widget.job.id != null) {
                //       jobsReference.child(widget.job.id).set({
                //         'custId': _customerIDController.data,
                //         'empId': _employeeIDController.data,
                //         'dateNow': _dateNowController.data,
                //         'dateInstall': _dateInstallController.data,
                //         'status': _statusController.text
                //       }).then((_) {
                //         Navigator.pop(context);
                //       });
                //     } else {
                //       jobsReference.push().set({
                //         'custId': _customerIDController.data,
                //         'empId': _employeeIDController.data,
                //         'dateNow': _dateNowController.data,
                //         'dateInstall': _dateInstallController.data,
                //         'status': _statusController.text
                //       }).then((_) {
                //         Navigator.pop(context);
                //       });
                //     }
                //   },
                // ),
              ],
            ),
          ),
          _buttonAction(JobStatus.New),
        ],
      ),
    );
  }
}
