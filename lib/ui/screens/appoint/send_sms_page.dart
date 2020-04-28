import 'package:flutter/material.dart';
import 'package:test_project/ui/widgets/full_width_raisedbutton_widget.dart';

import '../../ui_constant.dart';

class SendSMSPage extends StatefulWidget {
  @override
  _SendSMSPageState createState() => _SendSMSPageState();
}

class _SendSMSPageState extends State<SendSMSPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send SMS", style: appbarTextStyle,),
        backgroundColor: appBarColor,
         iconTheme: IconThemeData(color: appbarIconColor),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {},
                ),
                title: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Add phone number",
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 10,
                maxLength: 500,
                decoration: InputDecoration(hintText: "Description"),
              ),
              SizedBox(
                height: 20,
              ),
              FullWidthRaisedButtonWidget(
                title: 'Send message',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
