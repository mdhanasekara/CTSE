import 'package:CTSE/pages/IT19091358/login-pages/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/common/theme_helper.dart';
import 'package:CTSE/colors.dart' as color;
import '../../IT19204062/drawer-pages/admin_drawer.dart';

class ActiveUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final FirebaseAuth auth = FirebaseAuth.instance;
    late User user;
    late String currentUId;
    late String currentEmail;
    late DateTime currentdate;
    user = auth.currentUser!;
    currentUId = user.uid;
    currentEmail = user.email!;
    currentdate = user.metadata.lastSignInTime!;

    return Scaffold(
        drawer: AdminNavigationDrawer(),
        backgroundColor: color.AppColor.homePageBackground,
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
            child: Stack(children: [
              Builder(
                  builder: (context) => Container(
                          child: Stack(alignment: Alignment.center, children: <
                              Widget>[
                        ClipPath(
                          clipper: OuterClippedPart(),
                          child: Container(
                            color: color.AppColor.gradientSecond,
                            width: size.width,
                            height: size.height,
                          ),
                        ),
                        ClipPath(
                          clipper: InnerClippedPart(),
                          child: Container(
                            color: color.AppColor.gradientFirst,
                            width: size.width,
                            height: size.height,
                          ),
                        ),
                        ListView(
                          padding: const EdgeInsets.only(
                              top: 45, bottom: 8, right: 8, left: 8),
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        {Scaffold.of(context).openDrawer()},
                                    icon: Icon(Icons.menu,
                                        color: color.AppColor.homePageIcons,
                                        size: 30),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Current Users",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: color.AppColor.homePageTitle,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Color.fromARGB(255, 33, 4, 100),
                              child: Center(
                                  child: Text(
                                'ID     :     '
                                '${currentUId}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                              //child: Center(child: Text('${currentUId}')),
                            ),
                            Container(
                              height: 50,
                              color: Color.fromARGB(255, 113, 143, 194),
                              child: Center(
                                  child: Text(
                                'Email   :   '
                                '${currentEmail}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            Container(
                              height: 50,
                              color: Color.fromARGB(255, 141, 181, 241),
                              child: Center(
                                  child: Text(
                                'Login Date & Time   :   '
                                '${currentdate}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 8, 30, 8),
                                  child: Text(
                                    "Delete".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Successfully Deleted"),
                                          //content: Text(e.toString()),
                                        );
                                      });
                                  FirebaseAuth.instance.currentUser!.delete();
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                              ),
                            ),
                          ],
                        )
                      ]))),
            ])));
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.75, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
