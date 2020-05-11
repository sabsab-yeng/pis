import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pis/ui/screens/employee/emp_helper.dart';
import 'package:pis/ui/screens/employee/emp_model.dart';
import 'package:pis/ui/screens/employee/employee_input_page.dart';

import '../../ui_constant.dart';
class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  List<Employee> items = List();
  EmployeeDatabaseHelper db = EmployeeDatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllEmployees().then((employee) {
      setState(() {
        employee.forEach((employees) {
          items.add(Employee.fromMap(employees));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title: Text('Employees', style: appbarTextStyle,),
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
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Container(
                  height: 160,
                  child: SingleChildScrollView(
                                      child: Column(
                      children: <Widget>[
                        Divider(height: 5.0),
                        ListTile(
                          title: Text(
                            '${items[position].firstName}  ${items[position].lastName}' ,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${items[position].gender}',
                                style: new TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${items[position].phone}',
                                style: new TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.trash),
                                onPressed: () => 
                                _deleteEmployees(context, items[position], position),
                              ),
                           ]                               
                          )                                  ,
                        Text(     
                           '${items[position].jobId}',                                                               
                          style: new TextStyle(                                      
                      fontSize: 18.0,                                
                    fontStyle: FontStyle.italic,                                
                    ),
                  ),
            ],
      ),                               
              leading: Column(
            children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0)),
       CircleAvatar(
            backgroundColor: Colors.blueAccent,
                radius: 15.0,
                child: Text(
          '${items[position].id}',
            style: TextStyle(
           fontSize: 22.0,
           color: Colors.white,
          ),
        ),
      ),
    ],
 ),
    onTap: () => _navigateToEmployee(
      context, items[position]),
    ),
  ],
),
),
);
}),
),
    floatingActionButton: FloatingActionButton(
  child: Icon(Icons.add),
onPressed: () => _createNewEmployee(context),
    ),
  );
}
void deleteEmployee(BuildContext context, Employee employee, int position) async {
                                  db.deleteEmployee(employee.id).then((employee) {
                                    setState(() {
                                      items.removeAt(position);
                                    });
                                  });
                                }
                              
                                void _navigateToEmployee(BuildContext context, Employee employee) async {
                                  String result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EmployeeInfo(employee)),
                                  );
                              
                                  if (result == 'update') {
                                    db.getAllEmployees().then((employee) {
                                      setState(() {
                                        items.clear();
                                        employee.forEach((employees) {
                                          items.add(Employee.fromMap(employees));
                                        });
                                      });
                                    });
                                  }
                                }
                              
                                void _createNewEmployee(BuildContext context) async {
                                  String result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EmployeeInfo(Employee('', '','','', ''))),
                                  );
                              
                                  if (result == 'save') {
                                    db.getAllEmployees().then((employees) {
                                      setState(() {
                                        items.clear();
                                        employees.forEach((employee) {
                                          items.add(Employee.fromMap(employee));
                                        });
                                      });
                                    });
                                  }
                                }
                              }
                              
                              _deleteEmployees(BuildContext context, Employee item, int position) {
}
                              