import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../ui_constant.dart';
import '../../widgets/raised_button_widget.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  File imageFile;

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.pop(context);
  }

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.pop(context);
  }

  Future<void> _showDialogChoise(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choise"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  FlatButton(
                    child: Row(
                      children: [
                        Image.asset(
                          'images/camera.png',
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Camera"),
                      ],
                    ),
                    onPressed: () {
                      _openCamera(context);
                    },
                  ),
                  FlatButton(
                    child: Row(
                      children: [
                        Image.asset(
                          'images/gallery.png',
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Gallery"),
                      ],
                    ),
                    onPressed: () {
                      _openGallary(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _selectedImage() {
    if (imageFile == null) {
      return Text("No image");
    } else {
      return Image.file(imageFile, height: 80, width: 80,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(color: appbarIconColor),
         elevation: 0.0,
        title: Text(
          'Settings',
          style: appbarTextStyle,
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [Icon(Icons.person_outline)],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Main info'),
                SizedBox(
                  height: 40,
                ),
                // CircleAvatar(
                //   radius: 60,
                //   // backgroundImage: Image(imageFile, with: 60, height: 60),
                // ),
                _selectedImage(),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text(
                    'Change photo',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    _showDialogChoise(context);
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "First name", labelText: "First name"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Last name", labelText: "Last name"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: "Email", labelText: "Email"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: "Phone", labelText: "Phone"),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButtonWidget(
                  title: "Save",
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
