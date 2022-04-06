import 'package:CTSE/pages/IT19141848/admin-pages/list_user_page.dart';
import 'package:CTSE/pages/IT19204062/drawer-pages/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminNavigationDrawer(),
      backgroundColor: color.AppColor.homePageBackground,
      body: ListUserPage(),
    );
  }
}
