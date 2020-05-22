import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pis/models/tool.dart';
import 'package:pis/ui/screens/tools/add_material_page.dart';

import '../../ui_constant.dart';

class MaterialPage extends StatefulWidget {
  @override
  _MaterialPageState createState() => _MaterialPageState();
}

final toolsReference = FirebaseDatabase.instance.reference().child('tools');

class _MaterialPageState extends State<MaterialPage> {
  List<Tool> items;
  StreamSubscription<Event> _onToolAddedSubscription;
  StreamSubscription<Event> _onToolChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = List();

    _onToolAddedSubscription = toolsReference.onChildAdded.listen(_onMaterialAdded);
    _onToolChangedSubscription =
        toolsReference.onChildChanged.listen(_onMaterialUpdated);
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
          'Materials',
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
                              onPressed: () => _deleteMaterial(
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
                        onTap: () => _navigateToMaterial(context, items[position]),
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
        onPressed: () => _createNewMaterial(context),
      ),
    );
  }

  void _onMaterialAdded(Event event) {
    setState(() {
      items.add(Tool.fromSnapshot(event.snapshot));
    });
  }

  void _onMaterialUpdated(Event event) {
    var oldToolValue =
        items.singleWhere((tool) => tool.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldToolValue)] = Tool.fromSnapshot(event.snapshot);
    });
  }

  void _deleteMaterial(BuildContext context, Tool tool, int position) async {
    await toolsReference.child(tool.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToMaterial(BuildContext context, Tool tool) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMaterialPage(tool)),
    );
  }

  void _createNewMaterial(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMaterialPage(Tool(null, ''))),
    );
  }
}
