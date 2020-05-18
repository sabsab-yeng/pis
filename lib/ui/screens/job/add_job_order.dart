// import 'package:flutter/material.dart';
// import 'package:pis/models/job.dart';

// class AddJobDialog {
//   final teFirstName = TextEditingController();
//   final teLastName = TextEditingController();
//   final teDateNow = TextEditingController();
//   final teDateEnd = TextEditingController();
//   final teStatus = TextEditingController();
//   JobOrder jobOrder;

//   static const TextStyle linkStyle = const TextStyle(
//     color: Colors.blue,
//     decoration: TextDecoration.underline,
//   );

//   Widget buildAboutDialog(BuildContext context,
//       AddJobOrderCallback _myHomePageState, bool isEdit, JobOrder jobOrder) {
//     if (jobOrder != null) {
//       this.jobOrder = jobOrder;
//       teFirstName.text = jobOrder.custid;
//       teLastName.text = jobOrder.empid;
//       teDateNow.text = jobOrder.dateNow;
//       teDateEnd.text = jobOrder.dateInstall;
//       teStatus.text = jobOrder.status;
//     }

//     return AlertDialog(
//       title: Text(isEdit ? 'Edit detail!' : 'Add new JobOrder!'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             getTextField("Customer ID", teFirstName),
//             getTextField("Employee ID", teLastName),
//             getTextField("DD/MM/YYYY", teDateNow),
//             getTextField("DD/MM/YYYY", teDateEnd),
//             getTextField("Status", teStatus),
//             GestureDetector(
//               onTap: () => onTap(isEdit, _myHomePageState, context),
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
//                 child: getAppBorderButton(isEdit ? "Edit" : "Add",
//                     EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget getTextField(
//       String inputBoxName, TextEditingController inputBoxController) {
//     var loginBtn = Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: TextFormField(
//         controller: inputBoxController,
//         decoration: InputDecoration(
//           hintText: inputBoxName,
//         ),
//       ),
//     );

//     return loginBtn;
//   }

//   Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
//     var loginBtn = Container(
//       margin: margin,
//       padding: EdgeInsets.all(8.0),
//       alignment: FractionalOffset.center,
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFF28324E)),
//         borderRadius: BorderRadius.all(const Radius.circular(6.0)),
//       ),
//       child: Text(
//         buttonLabel,
//         style: TextStyle(
//           color: const Color(0xFF28324E),
//           fontSize: 20.0,
//           fontWeight: FontWeight.w300,
//           letterSpacing: 0.3,
//         ),
//       ),
//     );
//     return loginBtn;
//   }

//   JobOrder getData(bool isEdit) {
//     return JobOrder(isEdit ? jobOrder.id : "", teFirstName.text, teLastName.text,
//         teDateNow.text, teDateEnd.text, teStatus.text);
//   }

//   onTap(
//       bool isEdit, AddJobOrderCallback _myHomePageState, BuildContext context) {
//     if (isEdit) {
//       _myHomePageState.updateJob(getData(isEdit));
//     } else {
//       _myHomePageState.addJob(getData(isEdit));
//     }

//     Navigator.of(context).pop();
//   }

//   void setState(Null Function() param0) {}
// }

// //Call back of customer dashboad
// abstract class AddJobOrderCallback {
//   void addJob(JobOrder example);

//   void updateJob(JobOrder example);
// }



import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pis/models/job.dart';

import '../../ui_constant.dart';

class AddJobPage extends StatefulWidget {
  final JobOrder job;
  AddJobPage(this.job);

  @override
  State<StatefulWidget> createState() => _AddJobPageState();
}

final jobsReference = FirebaseDatabase.instance.reference().child('jobOrder');

class _AddJobPageState extends State<AddJobPage> {
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
                controller: _customerIDController,
                decoration: InputDecoration(labelText: 'Customer ID'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _employeeIDController,
                decoration: InputDecoration(labelText: 'Employee ID'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
                controller: _dateNowController,
                decoration: InputDecoration(labelText: 'Date now'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              TextField(
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

