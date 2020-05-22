import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pis/models/material.dart';

import '../../ui_constant.dart';
 
class AddMaterialPage extends StatefulWidget {
  final Tool material;
  AddMaterialPage(this.material);
 
  @override
  State<StatefulWidget> createState() => _AddMaterialPageState();
}
 
final notesReference = FirebaseDatabase.instance.reference().child('tools');
 
class _AddMaterialPageState extends State<AddMaterialPage> {
  TextEditingController _titleController;
 
  @override
  void initState() {
    super.initState();
 
    _titleController = TextEditingController(text: widget.material.title);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: appbarIconColor),
        title: Text(
          'Material information',
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
              child: (widget.material.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.material.id != null) {
                  notesReference.child(widget.material.id).set({
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