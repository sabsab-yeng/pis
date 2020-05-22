import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pis/models/tool.dart';
import 'package:pis/ui/widgets/full_width_raisedbutton_widget.dart';

import '../../ui_constant.dart';

class MaterialChoosePage extends StatefulWidget {
  @override
  _MaterialChoosePageState createState() => _MaterialChoosePageState();
}

class _MaterialChoosePageState extends State<MaterialChoosePage> {
  final toolsReference = FirebaseDatabase.instance.reference().child('tools');
  List<Tool> items;
  StreamSubscription<Event> _onToolAddedSubscription;

  @override
  void initState() {
    super.initState();
    items = List();

    _onToolAddedSubscription = toolsReference.onChildAdded.listen(_onToolAdded);
  }

  @override
  void dispose() {
    super.dispose();
    _onToolAddedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: appbarIconColor),
        title: Text(
          'Select your tool',
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
      body: Stack(
        children: [
          FutureBuilder(
              future: FirebaseDatabase.instance
                  .reference()
                  .child("tools")
                  .orderByKey()
                  .once(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: List.generate(
                      items.length,
                      (index) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              items[index].selected = !items[index].selected;

                              print(items[index].selected.toString());
                            });
                          },
                          selected: items[index].selected,
                          leading: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                  // backgroundColor: items[index].colorpicture,
                                  ),
                            ),
                          ),
                          title: Text('' + items[index].title.toString()),
                          // subtitle: Text(items[index].id.toString()),
                          trailing: (items[index].selected)
                              ? Icon(Icons.check_box)
                              : Icon(Icons.check_box_outline_blank),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    snapshot.error,
                    style: TextStyle(color: Colors.red),
                  );
                }
                return CircularProgressIndicator(
                  backgroundColor: Colors.red,
                );
              }),
          Positioned(
              bottom: 0,
              child: FullWidthRaisedButtonWidget(
                onPressed: () {
                  Navigator.pop(context);
                },
                title: "Comfirms",
              ))
        ],
      ),
    );
  }

  void _onToolAdded(Event event) {
    setState(() {
      items.add(Tool.fromSnapshot(event.snapshot));
    });
  }
}
