import 'package:flutter/material.dart';
import 'package:test_project/ui/screens/appoint/send_email_page.dart';
import '../../ui_construction.dart';
import '../../ui_construction.dart';

class AlterPage extends StatefulWidget {
  @override
  _AlterPageState createState() => _AlterPageState();
}

class _AlterPageState extends State<AlterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nofitication",
          style: appbarTextStyle,
        ),
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: appbarIconColor),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SendMailPage()));
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 100,
                  child: Text(
                    "Plan 1",
                    style: textFieldStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
