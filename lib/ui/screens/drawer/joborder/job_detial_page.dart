import 'package:flutter/material.dart';

import '../../../ui_constant.dart';

class JobDetailPage extends StatefulWidget {
  final int id;
  final String custid;
  final String empid;
  final String dateNow;
  final String dateInstall;

  JobDetailPage({this.id, this.custid, this.dateInstall, this.dateNow, this.empid});

  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Detial',
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.custid),
              SizedBox(
                height: 20,
              ),
              Text(widget.dateNow),
               SizedBox(
                height: 20,
              ),
              Text(widget.dateInstall),
            ],
          ),
        ),
      ),
    );
  }
}
