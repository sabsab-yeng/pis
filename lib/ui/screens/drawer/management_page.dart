import 'package:flutter/material.dart';
import 'package:pis/ui/screens/drawer/joborder/joborder_page.dart';
import 'package:pis/ui/widgets/inkwell_widget.dart';

import '../../ui_constant.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: appbarIconColor),
        title: Text(
          'Management',
          style: appbarTextStyle,
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
             InkWellWidget(onTap: (){}, title: "Customer",),
             Divider(),
             InkWellWidget(onTap: (){}, title: "Employee",),
             Divider(),
             InkWellWidget(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> JobPage()));
             }, title: "Job Order",),
            ],
          ),
        ),
      ),
    );
  }
}
