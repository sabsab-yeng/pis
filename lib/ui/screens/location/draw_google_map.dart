import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pis/ui/widgets/camera_picture_widget.dart';
import 'package:pis/ui/widgets/material_widget.dart';
import 'package:polymaker/core/models/location_polygon.dart';
import 'package:polymaker/polymaker.dart' as polymaker;

class DrawerGoogleMap extends StatefulWidget {
  @override
  _DrawerGoogleMapState createState() => _DrawerGoogleMapState();
}

class _DrawerGoogleMapState extends State<DrawerGoogleMap> {
  List<String> materialList = [
    "Fiber internet",
    "Router",
    "Spam",
    "Offensive",
    "Uncivil"
  ];

  List<String> selectedReportList = List();

  //Show material information
  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Choose Materials"),
            content: MultiSelectMaterial(
              materialList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Success"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  List<LocationPolygon> locationList;
  void getLocation() async {
    var result = await polymaker.getLocation(context);
    if (result != null) {
      setState(() {
        locationList = result;
      });
    }
  }

  //Show camera or image
  Future<void> _showDialogChoise(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choise"),
            content: CameraPictureWidget(),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    locationList = List<LocationPolygon>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Location Result: \n" +
                  (locationList != null
                      ? locationList
                          .map((val) => "[${val.latitude}, ${val.longitude}]\n")
                          .toString()
                      : ""),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              height: 45,
              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () => getLocation(),
                child: Text(
                  "Get Location",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(selectedReportList.join(" , ")),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () {
                _showReportDialog();
              },
              child: Text("Choose material"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlatButton(
                    child: Text("Camera"),
                    onPressed: () {
                      _showDialogChoise(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Customer Name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Phone',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Note',
              ),
              maxLength: 500,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Decline"),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Confirm"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
