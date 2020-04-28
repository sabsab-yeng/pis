import 'package:flutter/material.dart';

class PlanListPage extends StatefulWidget {
  @override
  _PlanListPageState createState() => _PlanListPageState();
}

class _PlanListPageState extends State<PlanListPage> {
  //Initialization of data sources
  final List<String> items = new List<String>.generate(200, (i)=>"Item $i");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: new Text('${items[index]}'),
          );
        },
        separatorBuilder: (context, index) {
          return new Divider(
            color: Colors.blue,
          );
        },
      ),
    );
  }
}
