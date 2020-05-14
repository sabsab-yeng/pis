import 'package:flutter/material.dart';
import 'package:pis/models/job.dart';

class AddJobDialog {
  final teFirstName = TextEditingController();
  final teLastName = TextEditingController();
  final teDateNow = TextEditingController();
  final teDateEnd = TextEditingController();
  final teStatus = TextEditingController();
  JobOrder jobOrder;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(BuildContext context,
      AddJobOrderCallback _myHomePageState, bool isEdit, JobOrder jobOrder) {
    if (jobOrder != null) {
      this.jobOrder = jobOrder;
      teFirstName.text = jobOrder.custid;
      teLastName.text = jobOrder.empid;
      teDateNow.text = jobOrder.dateNow;
      teDateEnd.text = jobOrder.dateInstall;
      teStatus.text = jobOrder.status;
    }

    return AlertDialog(
      title: Text(isEdit ? 'Edit detail!' : 'Add new JobOrder!'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Customer ID", teFirstName),
            getTextField("Employee ID", teLastName),
            getTextField("DD/MM/YYYY", teDateNow),
            getTextField("DD/MM/YYYY", teDateEnd),
            getTextField("Status", teStatus),
            GestureDetector(
              onTap: () => onTap(isEdit, _myHomePageState, context),
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Edit" : "Add",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: inputBoxController,
        decoration: InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  JobOrder getData(bool isEdit) {
    return JobOrder(isEdit ? jobOrder.id : "", teFirstName.text, teLastName.text,
        teDateNow.text, teDateEnd.text, teStatus.text);
  }

  onTap(
      bool isEdit, AddJobOrderCallback _myHomePageState, BuildContext context) {
    if (isEdit) {
      _myHomePageState.updateJob(getData(isEdit));
    } else {
      _myHomePageState.addJob(getData(isEdit));
    }

    Navigator.of(context).pop();
  }

  void setState(Null Function() param0) {}
}

//Call back of customer dashboad
abstract class AddJobOrderCallback {
  void addJob(JobOrder example);

  void updateJob(JobOrder example);
}
