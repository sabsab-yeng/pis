import 'package:flutter/material.dart';
import 'package:pis/ui/screens/employee/emp_helper.dart';
import 'package:pis/ui/screens/employee/emp_model.dart';
import 'package:pis/ui/screens/employee/employee_input_page.dart';
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

    db.getAllNotes().then((employee) {
      setState(() {
        employee.forEach((employee) {
          items.add(Employee.fromMap(employee));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ListView Employee'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Container(
                  height: 140,
                  child: Column(
                    children: <Widget>[
                      Divider(height: 5.0),
                      ListTile(
                        title: Text(
                          '${items[position].firstName}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        subtitle: Text(
                          '${items[position].phone}',
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
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
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => _deleteNote(
                                    context, items[position], position),
                              ),
                            ),
                          ],
                        ),
                        onTap: () => _navigateToNote(context, items[position]),
                      ),
                    ],
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
    );
  }

  void _deleteNote(BuildContext context, Employee employee, int position) async {
    db.deleteNote(employee.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Employee employee) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmployeeInfo(employee)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Employee.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmployeeInfo(Employee('', '','','', ''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((employee) {
        setState(() {
          items.clear();
          employee.forEach((employee) {
            items.add(Employee.fromMap(employee));
          });
        });
      });
    }
  }
}
