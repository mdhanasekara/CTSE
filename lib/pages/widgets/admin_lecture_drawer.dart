// ignore_for_file: unused_import, prefer_const_declarations, use_key_in_widget_constructors

import 'package:CTSE/login.dart';
import 'package:CTSE/pages/lecture/update_lecture_page.dart';
import 'package:CTSE/pages/module-pages/add_lecture_details.dart';
import 'package:CTSE/pages/module-pages/amin_view_lecture_details.dart';
import 'package:CTSE/pages/module-pages/lecture_details_list.dart';
import 'package:CTSE/pages/module-pages/module_outline_list.dart';
import 'package:CTSE/pages/module-pages/notices_list.dart';
import 'package:CTSE/pages/module-pages/user_dashboard.dart';
import 'package:flutter/material.dart';

class AdminLectureNavigationDrawer extends StatelessWidget {
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
              text: 'Dashboard',
              icon: Icons.dashboard,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Add Lecture Details',
              icon: Icons.bookmark,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'View Lecture Details List',
              icon: Icons.pages,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Sign Out',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 4),
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
          .push(MaterialPageRoute(builder: (context) => const UserDashboard()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const AddLectureDetails()));
      break;
    case 2:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ViewLectureDetails()));
      break;
    default:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Login()));
  }
}