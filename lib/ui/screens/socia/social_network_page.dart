import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginWithSocialPage extends StatefulWidget {
  @override
  _LoginWithSocialPageState createState() => _LoginWithSocialPageState();
}

class _LoginWithSocialPageState extends State<LoginWithSocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                width: 140,
                child: Container(
                  color: Colors.blue,
                  child: RaisedButton(
                    onPressed: null,
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.googlePlusG,
                            color: Colors.redAccent),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Google',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.facebookF, color: Colors.blue[900]),
                    Text(
                      'Facebook',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.phone, color: Colors.black87),
                    Text(
                      'Phone',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.twitter, color: Colors.blue[800]),
                    Text(
                      'Twitter',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    ));
  }
}
