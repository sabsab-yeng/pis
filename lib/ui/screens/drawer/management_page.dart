import 'package:flutter/material.dart';
import 'package:pis/ui/screens/customer/customer_page.dart';
import 'package:pis/ui/screens/drawer/example/home_page.dart';
import 'package:pis/ui/screens/drawer/joborder/job_page.dart';
import 'package:pis/ui/screens/employee/employee_page.dart';
import 'package:pis/ui/widgets/inkwell_widget.dart';
import '../../ui_constant.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: appbarIconColor),
        title: Text(
          'Management',
          style: appbarTextStyle,
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              InkWellWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CustomerPage()));
                },
                title: "Customer",
              ),
              Divider(),
              InkWellWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EmployeePage()));
                },
                title: "Employee",
              ),
              Divider(),
              InkWellWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JobOrderPage()));
                },
                title: "Job Order",
              ),
               Divider(),
              InkWellWidget(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                title: "Add user",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
