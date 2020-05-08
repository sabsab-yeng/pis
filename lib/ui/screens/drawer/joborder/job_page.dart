import 'package:flutter/material.dart';
import 'package:pis/ui/screens/drawer/joborder/job_data_helper.dart';
import 'package:pis/ui/screens/drawer/joborder/job_input_page.dart';
import 'package:pis/ui/screens/drawer/joborder/job_model.dart';

import '../../../ui_constant.dart';

class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  List<Job> items = List();
  JobDatabaseHelper db = JobDatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllJobs().then((employee) {
      setState(() {
        employee.forEach((employees) {
          items.add(Job.fromMap(employees));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employees',
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
                        '${items[position].custid}  ${items[position].empid}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${items[position].datenow}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            '${items[position].dateInstall}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            '${items[position].status}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          // Text(
                          //   '${items[position].description}',
                          //   style: new TextStyle(
                          //     fontSize: 18.0,
                          //     fontStyle: FontStyle.italic,
                          //   ),
                          // ),
                        ],
                      ),
                      leading: SingleChildScrollView(
                        child: Column(
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
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () =>
                                  deleteJob(context, items[position], position),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => _navigateToJob(context, items[position]),
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createNewJob(context),
      ),
    );
  }

  void deleteJob(BuildContext context, Job job, int position) async {
    db.deleteJob(job.id).then((job) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToJob(BuildContext context, Job job) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JobInfo(job)),
    );

    if (result == 'update') {
      db.getAllJobs().then((job) {
        setState(() {
          items.clear();
          job.forEach((jobs) {
            items.add(Job.fromMap(jobs));
          });
        });
      });
    }
  }

  void _createNewJob(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => JobInfo(Job('', '', '', '', ''))),
    );

    if (result == 'save') {
      db.getAllJobs().then((job) {
        setState(() {
          items.clear();
          job.forEach((jobs) {
            items.add(Job.fromMap(jobs));
          });
        });
      });
    }
  }
}
