import 'package:flutter/material.dart';
import 'package:pis/ui/ui_constant.dart';

class EmployeePage extends StatefulWidget {
  @override
  Insertemployees createState() => Insertemployees();
}

class Insertemployees extends State<EmployeePage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "insert Employee",
          style: appbarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: appbarIconColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Empployee information",
                style: appbarTextStyle,
              ),
              Flexible(
                flex: 0,
                child: Form(
                
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      TextFormField(
                       autofocus: true,
                        decoration: InputDecoration(
                          hintText: "First name",
                          labelText: "First name",                        
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autofocus: false,                           
                        decoration: InputDecoration(
                          hintText: "Last name",
                          labelText: "Last name",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(                                         
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Gender",
                          labelText: "Gender",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                      keyboardType: TextInputType.phone,                     
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Phone number",
                          labelText: "Phone number",
                        ),
                      ),
                        TextFormField(                        
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Job ID",
                          labelText: "Job ID",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        child: Text('Save'),
                        onPressed: () {                     
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
