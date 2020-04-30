import 'package:flutter/material.dart';
import 'package:pis/ui/screens/login/forgot/new_page_word_page.dart';
import 'package:pis/ui/ui_constant.dart';
import 'package:pis/ui/widgets/comfirm_code_widget.dart';
import 'package:pis/ui/widgets/full_width_raisedbutton_widget.dart';

class ComfirmEmailCodePage extends StatefulWidget {
  @override
  _ComfirmEmailCodePageState createState() => _ComfirmEmailCodePageState();
}

class _ComfirmEmailCodePageState extends State<ComfirmEmailCodePage> {
  List<TextEditingController> controllers = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comfirm code", style: appbarTextStyle,),
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
                Text(
                  "We send code for your email please check your email 4 Number",
                  style: appbarTextStyle,
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pinBoxs(50.0, controllers, Colors.white,
                      Colors.black, context, true),
                ),
                SizedBox(
                  height: 60,
                ),
                FlatButton(
                  child: Text("Resend Code"),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                FullWidthRaisedButtonWidget(
                  title: "Next",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPasswordPage()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
