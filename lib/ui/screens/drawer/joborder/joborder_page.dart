import 'package:flutter/material.dart';
import 'package:pis/ui/widgets/raised_button_widget.dart';

import '../../../ui_constant.dart';
class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: appbarIconColor),
        title: Text(
          'Job Order',
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
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(hintText: "CustID"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(hintText: "EmpID"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(hintText: "Date now"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(hintText: "Date Install"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                maxLength: 500,
                decoration: InputDecoration(hintText: "Description"),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButtonWidget(
                onPressed: () {},
                title: "Insert",
              ),
            ],
          ),
        ),
      ),
    );
  }
}