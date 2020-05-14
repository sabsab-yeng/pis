import 'package:flutter/material.dart';

import '../../ui_constant.dart';

class JobDetialPage extends StatefulWidget {
  final String id;
  final String dateInstall;
  final String status;
  JobDetialPage({this.id, this.dateInstall, this.status});
  @override
  _JobDetialPageState createState() => _JobDetialPageState();
}

class _JobDetialPageState extends State<JobDetialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'Job Detail',
          style: appbarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: appbarIconColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.id),
              SizedBox(
                height: 20,
              ),
              Text(widget.dateInstall),
              SizedBox(
                height: 20,
              ),
              Text(widget.status),
            ],
          ),
        ),
      ),
    );
  }
}
