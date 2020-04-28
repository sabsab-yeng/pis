import 'package:flutter/material.dart';
import '../../ui_constant.dart';
import '../../widgets/raised_button_widget.dart';

class GenerateSurveyPage extends StatefulWidget {
  @override
  _GenerateSurveyPageState createState() => _GenerateSurveyPageState();
}

class _GenerateSurveyPageState extends State<GenerateSurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text("Servey", style: appbarTextStyle,),
        iconTheme: IconThemeData(color: appbarIconColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('FTB: '),
                  SizedBox(
                    width: 20,
                  ),
                  Text('40 m'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('FTB: '),
                  SizedBox(
                    width: 20,
                  ),
                  Text('40 m'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('FTB: '),
                  SizedBox(
                    width: 20,
                  ),
                  Text('40 m'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('FTB: '),
                  SizedBox(
                    width: 20,
                  ),
                  Text('40 m'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('FTB: '),
                  SizedBox(
                    width: 20,
                  ),
                  Text('40 m'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('FTB: '),
                  SizedBox(
                    width: 20,
                  ),
                  Text('40 m'),
                ],
              ),
               SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Expanded(child: RaisedButtonWidget(title: "Add", onPressed: () {})),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: RaisedButtonWidget(title: "Save", onPressed: () {})),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
