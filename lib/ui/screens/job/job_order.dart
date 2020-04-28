import 'package:flutter/material.dart';
import 'package:test_project/ui/screens/appoint/calendar_page.dart';
import 'package:test_project/ui/ui_constant.dart';
import 'package:test_project/ui/widgets/raised_button_widget.dart';

class JobOrderPage extends StatefulWidget {
  @override
  _JobOrderPageState createState() => _JobOrderPageState();
}

class _JobOrderPageState extends State<JobOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Please Input your order ID",
                style: bigTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Input Order ID", hintStyle: textFieldStyle),
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButtonWidget(
                title: "Check your id",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CalendarPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
