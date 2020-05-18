import 'package:flutter/material.dart';
import 'package:pis/ui/screens/alter/alert_page.dart';
import 'package:pis/ui/screens/drawer/drawer_page.dart';
import 'package:pis/ui/screens/home/home_page.dart';
import 'package:pis/ui/screens/job/job_home_page.dart';
import 'package:pis/ui/screens/plan/plan_list_page.dart';
import '../../ui_constant.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomePage(), JobHomePage(), PlanListPage()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenuPage(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
       iconTheme: IconThemeData(color: appbarIconColor),
        centerTitle: true,
        title: Text("Home page", style: appbarTextStyle,),
        actions: <Widget>[

          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AlterPage()));
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Order'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            title: Text('Plan'),
          )
        ],
      ),
    );
  }
}
