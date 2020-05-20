import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pis/models/tool.dart';
import 'package:pis/ui/screens/tools/add_tool_page.dart';

import '../../ui_constant.dart';

class ToolsPage extends StatefulWidget {
  @override
  _ToolsPageState createState() => _ToolsPageState();
}

final toolsReference = FirebaseDatabase.instance.reference().child('tools');

class _ToolsPageState extends State<ToolsPage> {
  List<Tool> items;
  StreamSubscription<Event> _onToolAddedSubscription;
  StreamSubscription<Event> _onToolChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = List();

    _onToolAddedSubscription = toolsReference.onChildAdded.listen(_onToolAdded);
    _onToolChangedSubscription =
        toolsReference.onChildChanged.listen(_onToolUpdated);
  }

  @override
  void dispose() {
    _onToolAddedSubscription.cancel();
    _onToolChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: appbarIconColor),
        title: Text(
          'Tools',
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
      body: Center(
        child: FutureBuilder(
          future: FirebaseDatabase.instance.reference().child("tools").orderByKey().once(),
          builder:
              (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (context, position) {
                  return Column(
                    children: <Widget>[
                      Divider(height: 5.0),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${items[position].title}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.trash),
                              onPressed: () => _deleteTool(
                                  context, items[position], position),
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 15.0,
                          child: Text(
                            '${position + 1}',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () => _navigateToTool(context, items[position]),
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(
                snapshot.error,
                style: TextStyle(color: Colors.red),
              );
            }
            return CircularProgressIndicator(backgroundColor: Colors.red,);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createNewTool(context),
      ),
    );
  }

  void _onToolAdded(Event event) {
    setState(() {
      items.add(Tool.fromSnapshot(event.snapshot));
    });
  }

  void _onToolUpdated(Event event) {
    var oldToolValue =
        items.singleWhere((tool) => tool.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldToolValue)] = Tool.fromSnapshot(event.snapshot);
    });
  }

  void _deleteTool(BuildContext context, Tool tool, int position) async {
    await toolsReference.child(tool.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToTool(BuildContext context, Tool tool) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddToolPage(tool)),
    );
  }

  void _createNewTool(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddToolPage(Tool(null, ''))),
    );
  }
}
