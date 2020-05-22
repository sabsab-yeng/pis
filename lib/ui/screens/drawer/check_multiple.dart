import 'package:flutter/material.dart';
class MultipleChoosePage extends StatefulWidget {
  @override
  _MultipleChoosePageState createState() => _MultipleChoosePageState();
}

class _MultipleChoosePageState extends State<MultipleChoosePage> {
  var isSelected = false;
  var mycolor=Colors.white;

  BoxDecoration border;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: mycolor,
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
       ListTile(
            selected: isSelected,
            leading: const Icon(Icons.info),
            title: Text("Test"),
            subtitle: Text("Test Desc"),
            trailing: Text("3"),
            onLongPress: toggleSelection // what should I put here,
            )
      ]),
    );
  }

  // void toggleSelection() {
  //   setState(() {
  //     if (isSelected) {
  //       mycolor=Colors.white;
  //       isSelected = false;
  //     } else {
  //       mycolor=Colors.grey[300];
  //       isSelected = true;
  //     }
  //   });
  // }

  void toggleSelection() {
    setState(() {
      if (isSelected) {
        border = BoxDecoration(border: Border.all(color: Colors.white));
        mycolor = Colors.white;
        isSelected = false;
      } else {
        border = BoxDecoration(border: Border.all(color: Colors.grey));
        mycolor = Colors.grey[300];
        isSelected = true;
      }
    });
  }
}