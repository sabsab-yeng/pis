import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pis/ui/widgets/raised_button_widget.dart';

class YesWidget extends StatefulWidget {
  @override
  _YesWidgetState createState() => _YesWidgetState();
}

class _YesWidgetState extends State<YesWidget> {
  TextEditingController _dateNowController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);

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
               controller: _dateNowController,
              decoration: InputDecoration(labelText: "Date Time", suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    tooltip: 'Tap to open date now',
                    onPressed: () {
                      _dateNowController.text = formattedDate.toString();
                    },
                  ),),
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
