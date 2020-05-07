import 'package:flutter/material.dart';
import 'package:pis/ui/screens/employee/emp_helper.dart';
import 'package:pis/ui/screens/employee/emp_model.dart';
import '../../ui_constant.dart';

class EmployeeInfo extends StatefulWidget {
  final Employee employee;
  EmployeeInfo(this.employee);

  @override
  State<StatefulWidget> createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  EmployeeDatabaseHelper db = EmployeeDatabaseHelper();

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _genderController;
  TextEditingController _phoneController;
  TextEditingController _jogIdController;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.employee.firstName);
    _lastNameController = TextEditingController(text: widget.employee.lastName);
    _genderController = TextEditingController(text: widget.employee.gender);
    _phoneController = TextEditingController(text: widget.employee.phone);
    _jogIdController = TextEditingController(text: widget.employee.jobId);
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
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _jogIdController,
              decoration: InputDecoration(labelText: 'Job ID'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            RaisedButton(
              child:
                  (widget.employee.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.employee.id != null) {
                  db
                      .updateEmployee(Employee.fromMap({
                    'id': widget.employee.id,
                    'firstname': _firstNameController.text,
                    'lastname': _lastNameController.text,
                    'gender': _genderController.text,
                    'phone': _phoneController.text,
                    'jobId': _jogIdController.text,
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .saveEmployee(Employee(
                          _firstNameController.text,
                          _lastNameController.text,
                          _genderController.text,
                          _phoneController.text,
                          _jogIdController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
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
