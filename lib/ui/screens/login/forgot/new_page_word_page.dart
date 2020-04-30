import 'package:flutter/material.dart';
import 'package:pis/ui/screens/login/login_page.dart';
import 'package:pis/ui/widgets/full_width_raisedbutton_widget.dart';

import '../../../ui_constant.dart';

class NewPasswordPage extends StatefulWidget {
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Password", style: appbarTextStyle,),
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: appbarIconColor),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "New password",
                    labelText: "New password",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Comfirm new password",
                    labelText: "Comfirm new password",
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                FullWidthRaisedButtonWidget(
                  title: "Done",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
