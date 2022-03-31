import 'package:CTSE/pages/module-pages/add_module_details.dart';
import 'package:CTSE/pages/module-pages/lecturer_dashboard.dart';
import 'package:CTSE/pages/module-pages/view_notices_lecturer.dart';
import 'package:CTSE/pages/module-pages/view_outline_lecturer.dart';
import 'package:flutter/material.dart';

class LecturerDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
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
              text: 'View Notices',
              icon: Icons.bookmark,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'View Module Outline',
              icon: Icons.pages,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Add Module Details',
              icon: Icons.add,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'View Study Materials',
              icon: Icons.book,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Add Study Materials',
              icon: Icons.publish_sharp,
              onClicked: () => selectedItem(context, 5),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 6),
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
          .push(MaterialPageRoute(builder: (context) => LecturerDashboard()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ViewNotices()));
      break;
    case 2:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ViewModuleOutline()));
      break;
    case 3:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddModuleDetails()));
      break;
    case 4:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddModuleDetails()));
      break;
    case 5:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddModuleDetails()));
      break;
    default:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddModuleDetails()));
  }
}
