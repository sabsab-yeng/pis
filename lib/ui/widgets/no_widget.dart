import 'package:flutter/material.dart';
import 'package:pis/ui/widgets/raised_button_widget.dart';

class NoWidget extends StatefulWidget {
  @override
  _NoWidgetState createState() => _NoWidgetState();
}

class _NoWidgetState extends State<NoWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Note",
              ),
              maxLength: 500,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButtonWidget(
              onPressed: () {
                Navigator.pop(context);
              },
              title: "Confirm",
            ),
          ],
        ),
      ),
    );
  }
}
