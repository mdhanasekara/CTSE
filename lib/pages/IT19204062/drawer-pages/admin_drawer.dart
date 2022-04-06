// ignore_for_file: unused_import, prefer_const_declarations, use_key_in_widget_constructors
import 'package:CTSE/pages/IT19056258/add_lecture_details.dart';
import 'package:CTSE/pages/IT19056258/amin_view_lecture_details.dart';
import 'package:CTSE/pages/IT19091358/login-pages/Login.dart';
import 'package:CTSE/pages/IT19141848/admin-pages/add_user_page.dart';
import 'package:CTSE/pages/IT19141848/admin-pages/registered_users.dart';
import 'package:CTSE/pages/IT19204062/student-pages/student_dashboard.dart';
import 'package:flutter/material.dart';

import '../../IT19091358/admin-pages/active_users.dart';

class AdminNavigationDrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 48),
            buildMenuItem(
              text: 'Add Users',
              icon: Icons.add_circle,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Registered Users',
              icon: Icons.supervised_user_circle_outlined,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Active Users',
              icon: Icons.supervised_user_circle_sharp,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Sign Out',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 3),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color, fontSize: 17)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddUserPage()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      break;
    case 2:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  ActiveUsers()));
      break;
    default:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Login()));
  }
}
