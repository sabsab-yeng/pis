import 'package:flutter/material.dart';
import 'package:pis/ui/screens/login/forgot/comfirm_email_code_page.dart';
import 'package:pis/ui/ui_constant.dart';
import 'package:pis/ui/widgets/full_width_raisedbutton_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset password", style: appbarTextStyle,),
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: appbarIconColor),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Please enter your email', style: appbarTextStyle,),
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      labelText: "Enter your email",
                    ),
                    validator: (values) {
                       if (values.isEmpty) {
                          return 'Please type email';
                        }
                    },
                     onSaved: (values) => _email = values,

                  ),
                  SizedBox(
                    height: 60,
                  ),
                  FullWidthRaisedButtonWidget(
                    title: "Comfirm",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ComfirmEmailCodePage()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
