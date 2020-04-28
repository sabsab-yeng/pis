import 'package:flutter/material.dart';

class RaisedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  RaisedButtonWidget({this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 200,
      child: RaisedButton(
        elevation: 0,
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 200.0, minHeight: 60.0),
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
