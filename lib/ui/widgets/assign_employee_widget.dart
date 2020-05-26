import 'package:flutter/material.dart';
import 'package:pis/models/employee.dart';

class AssignEmployeeWidget extends StatefulWidget {
  final Key key;
  final Employee employee;
  final ValueChanged<bool> isSelected;

  AssignEmployeeWidget({this.employee, this.isSelected, this.key});

  @override
  _AssignEmployeeWidgetState createState() => _AssignEmployeeWidgetState();
}

class _AssignEmployeeWidgetState extends State<AssignEmployeeWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.isSelected(isSelected);
          });
        },
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 40.0,
                    // child: Text(widget.employee.firstname.substring(0, 1) + "." + widget.employee.lastname.substring(0, 1)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.employee.firstname}',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.employee.lastname}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            isSelected
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
