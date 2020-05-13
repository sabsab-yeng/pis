import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pis/models/employee.dart';
import 'package:pis/services/employee_service.dart';
import 'package:pis/ui/screens/employee/add_employee.dart';
import '../../ui_constant.dart';

class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage>
    implements AddEmployeeCallback {
  bool _anchorToBottom = false;

  // instance of util class

  EmployeeUtil databaseUtil;

  @override
  void initState() {
    super.initState();
    databaseUtil = EmployeeUtil();
    databaseUtil.initState();
  }

  @override
  void dispose() {
    super.dispose();
    databaseUtil.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // it will show title of screen

    Widget _buildTitle(BuildContext context) {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Employees', style: appbarTextStyle),
            ],
          ),
        ),
      );
    }

//It will show new customer icon
    List<Widget> _buildActions() {
      return <Widget>[
        IconButton(
          icon: const Icon(
            Icons.add,
          ), // display pop for new entry
          onPressed: () => showEditWidget(null, false),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(context),
        actions: _buildActions(),
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

      // Firebase predefile list widget. It will get customer info from firebase database
      body: FirebaseAnimatedList(
        key: ValueKey<bool>(_anchorToBottom),
        query: databaseUtil.getEmployee(),
        reverse: _anchorToBottom,
        sort: _anchorToBottom
            ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
            : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return SizeTransition(
            sizeFactor: animation,
            child: showEmployees(snapshot),
          );
        },
      ),
    );
  }

  //It will display a item in the list of employees.
  Widget showEmployees(DataSnapshot res) {
    Employee employee = Employee.fromSnapshot(res);

    var item = Card(
      child: Container(
          child: Center(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 30.0,
                  child: Text(getShortName(employee)),
                  backgroundColor: const Color(0xFF20283e),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          employee.firstname,
                          // set some style to text
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.lightBlueAccent),
                        ),
                        Text(
                          employee.lastname,
                          // set some style to text
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.lightBlueAccent),
                        ),
                        Text(
                          employee.phone,
                          // set some style to text
                          style: TextStyle(fontSize: 20.0, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: const Color(0xFF167F67),
                      ),
                      onPressed: () => showEditWidget(employee, true),
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.trash,
                          color: const Color(0xFF167F67)),
                      onPressed: () => showAlertDialog(context, employee),
                    ),
                  ],
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
    );

    return item;
  }
  showAlertDialog(BuildContext context, Employee employee) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("No"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Yes"),
    onPressed:  () {
      deleteEmployee(employee);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("ແຈ້ງເຕືອນ"),
    content: Text("ທ່ານຕ້ອງການລຶບຫຼືບໍ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  //Get first letter from the name of employee
  String getShortName(Employee employee) {
    String shortName = "";
    if (employee.firstname.isNotEmpty) {
      shortName = employee.firstname.substring(0, 1);
    }
    return shortName;
  }

  //Display popup in employee info update mode.
  showEditWidget(Employee employee, bool isEdit) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AddEmployeeDialog().buildAboutDialog(context, this, isEdit, employee),
    );
  }

  //Delete a entry from the Firebase console.
  deleteEmployee(Employee employee) {
    setState(() {
      databaseUtil.deleteEmployee(employee);
    });
  }

// Call util method for add employee information
  @override
  void addEmployee(Employee employee) {
      setState(() {
      databaseUtil.addEmployee(employee);
    });
    }

    // call util method for update old data.
  
    @override
    void updateEmployee(Employee employee) {
     setState(() {
      databaseUtil.updateEmployee(employee);
    });
  }
}
