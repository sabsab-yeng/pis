import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pis/models/tool.dart';

import '../../ui_constant.dart';
 
class AddToolPage extends StatefulWidget {
  final Tool note;
  AddToolPage(this.note);
 
  @override
  State<StatefulWidget> createState() => _AddToolPageState();
}
 
final notesReference = FirebaseDatabase.instance.reference().child('tools');
 
class _AddToolPageState extends State<AddToolPage> {
  TextEditingController _titleController;
 
  @override
  void initState() {
    super.initState();
 
    _titleController = TextEditingController(text: widget.note.title);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: appbarIconColor),
        title: Text(
          'Tool information',
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
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.note.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.note.id != null) {
                  notesReference.child(widget.note.id).set({
                    'title': _titleController.text,
                  }).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  notesReference.push().set({
                    'title': _titleController.text,
                  }).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}