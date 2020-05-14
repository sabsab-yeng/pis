import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pis/models/job.dart';
import 'package:pis/services/job_service.dart';
import 'package:pis/ui/screens/job/add_job_order.dart';
import '../../ui_constant.dart';

class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> implements AddJobOrderCallback {
  bool _anchorToBottom = false;

  // instance of util class

  JobApiService databaseUtil;

  @override
  void initState() {
    super.initState();
    databaseUtil = JobApiService();
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
              Text('Job Orders', style: appbarTextStyle),
            ],
          ),
        ),
      );
    }

//It will show new Example icon
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

      // Firebase predefile list widget. It will get example info from firebase database
      body: FirebaseAnimatedList(
        key: ValueKey<bool>(_anchorToBottom),
        query: databaseUtil.getJob(),
        reverse: _anchorToBottom,
        sort: _anchorToBottom
            ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
            : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return SizeTransition(
            sizeFactor: animation,
            child: showCustomer(snapshot),
          );
        },
      ),
    );
  }

  //It will display a item in the list of Examples.
  Widget showCustomer(DataSnapshot res) {
    JobOrder jobOrder = JobOrder.fromSnapshot(res);
    var item = Card(
      child: Container(
        child: Center(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                child: Text(getShortName(jobOrder)),
                backgroundColor: const Color(0xFF20283e),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        jobOrder.custid,
                        // set some style to text
                        style: TextStyle(
                            fontSize: 20.0, color: Colors.lightBlueAccent),
                      ),
                      Text(
                        jobOrder.empid,
                        // set some style to text
                        style: TextStyle(
                            fontSize: 20.0, color: Colors.lightBlueAccent),
                      ),
                      Text(
                        jobOrder.dateInstall,
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
                    onPressed: () => showEditWidget(jobOrder, true),
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.trash,
                        color: const Color(0xFF167F67)),
                    onPressed: () => deleteCustomer(jobOrder),
                  ),
                ],
              ),
            ],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      ),
    );

    return item;
  }

  //Get first letter from the name of customer
  String getShortName(JobOrder jobOrder) {
    String shortName = "";
    if (!jobOrder.status.isEmpty) {
      shortName = jobOrder.status.substring(0, 3);
    }
    return shortName;
  }

  //Display popup in customer info update mode.
  showEditWidget(JobOrder jobOrder, bool isEdit) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AddJobDialog().buildAboutDialog(context, this, isEdit, jobOrder),
    );
  }

  //Delete a entry from the Firebase console.
  deleteCustomer(JobOrder jobOrder) {
    setState(() {
      databaseUtil.deleteJob(jobOrder);
    });
  }

// Call util method for add jobOrder information
  @override
  void addJob(JobOrder jobOrder) {
    setState(() {
      databaseUtil.addJob(jobOrder);
    });
  }

  // call util method for update old data.
  @override
  void updateJob(JobOrder example) {
    setState(() {
      databaseUtil.updateJob(example);
    });
  }
}
