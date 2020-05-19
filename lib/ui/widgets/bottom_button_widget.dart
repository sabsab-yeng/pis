import 'package:flutter/material.dart';

class BottomButtonWidget extends StatelessWidget {
  final Function onClicked;
  final String title;
  final Icon icon;
  final Color backgroundColor;
  BottomButtonWidget(
      {this.icon, this.backgroundColor, this.onClicked, this.title = ""});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: (backgroundColor == null)
            ? Theme.of(context).primaryColor
            : this.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            (this.icon == null) ? Container() : icon,
            FlatButton(
                child: Text(title.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () {
                  if (onClicked != null) {
                    onClicked();
                  }
                })
          ],
        ),
      ),
    );
  }
}
