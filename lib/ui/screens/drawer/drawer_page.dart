import 'package:flutter/material.dart';
import 'package:pis/ui/screens/location/check_location_page.dart';
import 'package:pis/ui/screens/settings/setting_page.dart';
import 'package:pis/ui/widgets/menu_drawer_widget.dart';
import '../home/root_page.dart';

class DrawerMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    'images/user.png',
                    height: 80,
                    width: 80,
                  ),
                  Text(
                    "Fname and Lname",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            MenuDrawerWidget(
              icon: Icons.home,
              title: "Home",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RootPage()));
              },
            ),
             MenuDrawerWidget(
              icon: Icons.map,
              title: "Google map",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckLocationPage()));
              },
            ),
            MenuDrawerWidget(
              icon: Icons.settings,
              title: "Settings",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
              },
            ),
            MenuDrawerWidget(
              icon: Icons.language,
              title: "Language",
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>RootPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
