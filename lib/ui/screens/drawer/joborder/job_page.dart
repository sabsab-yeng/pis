import 'package:flutter/material.dart';
import 'package:pis/ui/screens/drawer/joborder/job_data_helper.dart';
import 'package:pis/ui/screens/drawer/joborder/job_model.dart';

import '../../../ui_constant.dart';
import 'job_input_page.dart';
class JobOrderPage extends StatefulWidget {
  @override
  _JobOrderPageState createState() => _JobOrderPageState();
}

class _JobOrderPageState extends State<JobOrderPage> {
  List<Job> items = List();
  JobDatabaseHelper db = JobDatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllJobs().then((job) {
      setState(() {
        job.forEach((jobs) {
          items.add(Job.fromMap(jobs));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title: Text('JOB Order', style: appbarTextStyle,),
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
                          '${items[position].datenow}  ${items[position].dateinstall}' ,
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
                              '${items[position].dateinstall}',
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
                          ],
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
                                onPressed: () => deleteJob(
                                    context, items[position], position),
                              ),
                            ),
                          ],
                        ),
                        onTap: () => _navigateToJobOrder(context, items[position]),
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
    db.deleteEmployee(job.id).then((employees) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToJobOrder(BuildContext context, Job job) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JobInfoPage(job)),
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
      MaterialPageRoute(builder: (context) => JobInfoPage(Job('', '','','', '',''))),
    );

    if (result == 'save') {
      db.getAllJobs().then((employees) {
        setState(() {
          items.clear();
          employees.forEach((employee) {
            items.add(Job.fromMap(employee));
          });
        });
      });
    }
  }
}
