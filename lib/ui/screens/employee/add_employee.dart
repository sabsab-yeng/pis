import 'package:flutter/material.dart';
import 'package:pis/models/employee.dart';

class AddEmployeeDialog {
  final teFirstName = TextEditingController();
  final teLastName = TextEditingController();
  final teGender = TextEditingController();
  final tePhone = TextEditingController();
  Employee employee;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(BuildContext context,
      AddEmployeeCallback _myHomePageState, bool isEdit, Employee employee) {
    if (employee != null) {
      this.employee = employee;
      teFirstName.text = employee.firstname;
      teLastName.text = employee.lastname;
      teGender.text = employee.gender;
      tePhone.text = employee.phone;
    }

    return AlertDialog(
      title: Text(isEdit ? 'Edit detail!' : 'Add new Employee!'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("First Name", teFirstName),
            getTextField("Last Name", teLastName),
            getTextField("Gender", teGender),
            getTextField("Phone", tePhone),
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
Employee getData(bool isEdit) {
    return Employee(
      isEdit ? employee.id : "", 
    teFirstName.text, teLastName.text,
        teGender.text, tePhone.text);
  }

  onTap(bool isEdit, AddEmployeeCallback _myHomePageState, BuildContext context) {
    if (isEdit) {
      _myHomePageState.updateEmployee(getData(isEdit));
    } else {
      _myHomePageState.addEmployee(getData(isEdit));
    }

   Navigator.of(context).pop(); 

 }
}
//Call back of customer dashboad
abstract class AddEmployeeCallback {
  void addEmployee(Employee employee);

  void updateEmployee(Employee employee);
}