import 'package:flutter/material.dart';

class FullWidthRaisedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  FullWidthRaisedButtonWidget({this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 80,
      width: sw,
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
            constraints: BoxConstraints(maxWidth: sw, minHeight: 60.0),
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
