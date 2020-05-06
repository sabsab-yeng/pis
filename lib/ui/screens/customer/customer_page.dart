import 'package:flutter/material.dart';
import 'package:pis/ui/ui_constant.dart';
class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: appbarIconColor),
        title: Text('Customer',
        style: appbarTextStyle,
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "id", labelText: "id",
              ),
            ),
            SizedBox(height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Fist name", labelText: "First name",
              ),
            ),
            SizedBox(height: 20.0,
            ),
            TextFormField(
            decoration: InputDecoration(
              hintText: "Gender", labelText: "Gender"
            ),
            ),
            SizedBox(height: 20.0,
            ),
             TextFormField(
               decoration: InputDecoration(
                 hintText: "Telephone", labelText: "Telephone",
                 ),
          ),
          ],
          ),
      ),
      ),
      
    );
    
  }
}