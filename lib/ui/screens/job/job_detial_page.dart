import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:pis/bloc/job_delial_bloc.dart';
import 'package:pis/enum/enum.dart';
import 'package:pis/models/job.dart';
import 'package:pis/ui/screens/job/assign_employee_page.dart';
import 'package:pis/ui/screens/location/draw_google_map.dart';
import 'package:pis/ui/widgets/assign_employee_widget.dart';
import 'package:pis/ui/widgets/bottom_button_widget.dart';
import 'package:pis/ui/widgets/no_widget.dart';
import 'package:pis/ui/widgets/yes_widget.dart';
import '../../ui_constant.dart';

class JobDetPage extends StatefulWidget {
  final JobOrder job;
  JobDetPage(this.job);

  @override
  State<StatefulWidget> createState() => _JobDetPageState();
}

final jobsReference = FirebaseDatabase.instance.reference().child('jobOrder');

class _JobDetPageState extends State<JobDetPage> {
  JobDetialBloc jobDetialBloc = JobDetialBloc();
// Form key
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  JobStatus jobStatus;

  Text _customerIDController;
  Text _employeeIDController;
  Text _dateNowController;
  TextEditingController _dateInstallController;
  TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _customerIDController = Text(widget.job.custid);
    _employeeIDController = Text(widget.job.empid);
    _dateNowController = Text(widget.job.dateNow);
    _dateInstallController =
        TextEditingController(text: widget.job.dateInstall);
    _statusController = TextEditingController(text: widget.job.status);
  }

  //Check status
  Widget _buttonAction(JobStatus jobStatus) {
    if (jobStatus == JobStatus.New) {
      //Create the button
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "Assing employee",
        icon: Icon(Icons.straighten, color: Colors.white),
        onClicked: () {
          // _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
          //   return LookingEmployeeWidget();
          // });
          _changedStatus();
          openEmployee(context);
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> AssignEmployeeWidget()));
        },
      );
    } else if (jobStatus == JobStatus.SiteSurvey) {
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "Site survey",
        icon: Icon(Icons.location_on, color: Colors.white),
        onClicked: () {
          _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
            return DrawerGoogleMap();
          });

          openLocation(context);
          //   _changedStatus();
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => DrawerGoogleMap()));
        },
      );
    } else if (jobStatus == JobStatus.SiteSurvey) {
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "Material Request",
        icon: Icon(Icons.location_on, color: Colors.white),
        onClicked: () {
          // _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
          //   return LookingEmployeeWidget();
          // });

          openLocation(context);
        },
      );
    } else if (jobStatus == JobStatus.InstallationExecution) {
      return Positioned(
        bottom: 0,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                child: Text("No"),
                onPressed: () {
                  openNoButton(context);
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.51,
              ),
              RaisedButton(
                child: Text("Yes"),
                onPressed: () {
                  openYesButton(context);
                },
              ),
            ],
          ),
        ),
      );
    } else if (jobStatus == JobStatus.Testing) {
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "Testing",
        icon: Icon(Icons.report, color: Colors.white),
        onClicked: () {
          // _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
          //   return LookingEmployeeWidget();
          // });

          _changedStatus();
        },
      );
    } else if (jobStatus == JobStatus.TechReport) {
      return BottomButtonWidget(
        backgroundColor: Colors.blue,
        title: "Customer Confirm",
        icon: Icon(Icons.thumb_up, color: Colors.white),
        onClicked: () {
          // _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
          //   return LookingEmployeeWidget();
          // });
          _changedStatus();
        },
      );
    }
    // By default returning nothing
    return Container();
  }

  //Need to display Sitesurvey
  openLocation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 600,
            child: DrawerGoogleMap(),
          ),
        );
      },
    );
  }

  //Assign employee
  openEmployee(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 600,
            child: AssignEmployeePage(),
          ),
        );
      },
    );
  }

  //Create no and yes button after Installation
  openNoButton(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NoWidget();
      },
    );
  }

  //Create Yes button
  openYesButton(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: YesWidget(),
        );
      },
    );
  }

  String _selectedDateInstall = 'Tap to select date install';

  Future<void> _selectDateInstall(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2090),
    );
    if (d != null)
      setState(() {
        _selectedDateInstall = DateFormat('dd-MM-yyyy').format(d);
      });
    _dateInstallController.text = _selectedDateInstall.toString();
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
                Text("Date Create: " + _dateNowController.data),
                Padding(padding: EdgeInsets.all(5.0)),
                TextField(
                  controller: _dateInstallController,
                  decoration: InputDecoration(
                    hintText: _selectedDateInstall,
                    labelText: 'Date install',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      tooltip: 'Tap to open date install',
                      onPressed: () {
                        _selectDateInstall(context);
                      },
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                TextField(
                  controller: _statusController,
                  decoration: InputDecoration(labelText: 'Status'),
                ),
              ],
            ),
          ),

          // _buttonAction(JobStatus.New),
          _buttonAction(JobStatus.SiteSurvey),
          // _buttonAction(JobStatus.Testing),
          // _buttonAction(JobStatus.MaterialRequest),
          // _buttonAction(JobStatus.InstallationExecution),
          // _buttonAction(JobStatus.TechReport),
          // _buttonAction(JobStatus.CustomerConfirm),
        ],
      ),
    );
  }

  void _changedStatus() {
    if (widget.job.id != null) {
      jobsReference.child(widget.job.id).set({
        'custId': _customerIDController.data,
        'empId': _employeeIDController.data,
        'dateNow': _dateNowController.data,
        'dateInstall': _dateInstallController.text,
        'status': _statusController.text
      }).then((_) {
        Navigator.pop(context);
      });
    } else {
      jobsReference.push().set({
        'custId': _customerIDController.data,
        'empId': _employeeIDController.data,
        'dateNow': _dateNowController.data,
        'dateInstall': _dateInstallController.text,
        'status': _statusController.text
      }).then((_) {
        Navigator.pop(context);
      });
    }
  }
}
