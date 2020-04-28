import 'package:flutter/material.dart';

class StackButtonWiget extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final Function onPressed;
  final Icon iconPath;
  final Color mainColor;
  final bool enabled;
  final bool isLoading;
  StackButtonWiget(
      {this.onPressed,
      this.titleText = "",
      this.subtitleText = "",
      this.iconPath,
      this.enabled = true,
      this.isLoading = false,
      this.mainColor = Colors.red});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: RaisedButton(
        onPressed: () {
          if (this.enabled == false) return null;

          if (onPressed != null) {
            onPressed();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: (isLoading == false)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          titleText,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        (subtitleText != null)
                            ? Text(
                                subtitleText,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12),
                              )
                            : Container(height: 0)
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white))),
            ),
            iconPath ?? Container(),
          ],
        ),
        color: (enabled == true) ? this.mainColor : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}