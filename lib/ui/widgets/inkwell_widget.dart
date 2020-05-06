import 'package:flutter/material.dart';

class InkWellWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  InkWellWidget({this.onTap, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: () {
          if(onTap !=null){
            onTap();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
            ),
            Icon(Icons.navigate_next, size: 40),
          ],
        ),
      ),
    );
  }
}
