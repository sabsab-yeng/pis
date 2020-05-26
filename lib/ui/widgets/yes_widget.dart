import 'package:flutter/material.dart';
import 'package:pis/ui/widgets/raised_button_widget.dart';

class YesWidget extends StatefulWidget {
  @override
  _YesWidgetState createState() => _YesWidgetState();
}

class _YesWidgetState extends State<YesWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Name"),
            ),
            SizedBox(
              height: 20,
            ),
             TextFormField(
              decoration: InputDecoration(hintText: "DateTime"),
            ),
            SizedBox(
              height: 20,
            ),
             TextFormField(
              decoration: InputDecoration(hintText: "Phone"),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButtonWidget(
              onPressed: () {
                Navigator.pop(context);
              },
              title: "Confirm",
            )
          ],
        ),
      ),
    );
  }
}
