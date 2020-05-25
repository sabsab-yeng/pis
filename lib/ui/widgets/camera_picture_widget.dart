
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPictureWidget extends StatefulWidget {
  @override
  _CameraPictureWidgetState createState() => _CameraPictureWidgetState();
}

class _CameraPictureWidgetState extends State<CameraPictureWidget> {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
