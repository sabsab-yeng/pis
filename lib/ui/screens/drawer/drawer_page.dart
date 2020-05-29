import 'package:flutter/material.dart';
import 'package:pis/ui/screens/settings/profile_page.dart';
import 'package:pis/ui/screens/settings/setting_page.dart';
import 'package:pis/ui/widgets/menu_drawer_widget.dart';
import '../home/root_page.dart';
import 'management_page.dart';

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RootPage()));
              },
            ),
            MenuDrawerWidget(
              icon: Icons.settings,
              title: "Settings",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              },
            ),
            MenuDrawerWidget(
              icon: Icons.dialpad,
              title: "Manage Data",
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagementPage()));
              },
            ),
            MenuDrawerWidget(
              icon: Icons.dialpad,
              title: "Profile",
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
