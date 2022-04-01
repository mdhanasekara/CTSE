import 'package:CTSE/pages/module-pages/module_outline_list.dart';
import 'package:CTSE/pages/module-pages/notices_list.dart';
import 'package:CTSE/pages/module-pages/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;
class UserNavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        // color: Color.fromRGBO(50, 75, 205, 1),
        color: color.AppColor.formTextColor,
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
              text: 'Notices',
              icon: Icons.bookmark,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Module Outline',
              icon: Icons.pages,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Study Materials',
              icon: Icons.book,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Profile',
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
          .push(MaterialPageRoute(builder: (context) => UserDashboard()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NoticesList()));
      break;
    case 2:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ModuleOutlineList()));
      break;
    case 3:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NoticesList()));
      break;
    default:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NoticesList()));
  }
}
