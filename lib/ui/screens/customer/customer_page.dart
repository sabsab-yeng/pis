import 'package:flutter/material.dart';
import 'package:pis/ui/ui_constant.dart';
import 'package:pis/ui/widgets/raised_button_widget.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: appbarIconColor),
        title: Text(
          'Customer',
          style: appbarTextStyle,
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Fist name",
                  labelText: "First name",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration:
                    InputDecoration(hintText: "Gender", labelText: "Gender"),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Telephone",
                  labelText: "Telephone",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButtonWidget(
                title: "Insert",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
