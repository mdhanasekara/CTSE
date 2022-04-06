import 'package:CTSE/pages/IT19141848/user-pages/model/user_model.dart';
import 'package:CTSE/pages/IT19204062/drawer-pages/lecturer_drawer.dart';
import 'package:CTSE/pages/IT19204062/drawer-pages/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:CTSE/colors.dart' as color;

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    print(user!.email);
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: user!.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        loggedInUser.fname = doc['fname'];
        loggedInUser.lname = doc['lname'];
        loggedInUser.type = doc['type'];
        loggedInUser.email = doc['email'];
        loggedInUser.mobile = doc['mobile'];
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      drawer: loggedInUser.type == 'lecturer'
          ? LecturerDrawer()
          : UserNavigationDrawer(),
      body: SingleChildScrollView(
        child: Stack(children: [
          Builder(
              builder: (context) => Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 0, right: 0, bottom: 5),
                    child: Stack(
                      children: <Widget>[
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
                        Positioned(
                          top: 30,
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
                                "User Profile",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: color.AppColor.homePageTitle,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(25, 70, 25, 10),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              Ink.image(
                                image: NetworkImage(
                                  'https://media.gettyimages.com/photos/illustration-of-happy-smiling-businessman-in-suit-with-laptop-sitting-picture-id1248415323?b=1&k=20&m=1248415323&s=170667a&w=0&h=xEgyA_jfBpP6S4DobMUR_SE1LtwbMyuiQz0nSvM1zWg=',
                                ),
                                child: InkWell(
                                  onTap: () {},
                                ),
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${loggedInUser.fname} ${loggedInUser.lname}",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 4.0),
                                      alignment: Alignment.topLeft,
                                    ),
                                    Card(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                ...ListTile.divideTiles(
                                                  color: Colors.grey,
                                                  tiles: [
                                                    ListTile(
                                                      leading:
                                                          Icon(Icons.person),
                                                      title: Text("User Type"),
                                                      subtitle: Text(
                                                          "${loggedInUser.type}"),
                                                    ),
                                                    ListTile(
                                                      leading:
                                                          Icon(Icons.email),
                                                      title: Text("Email"),
                                                      subtitle: Text(
                                                          "${loggedInUser.email}"),
                                                    ),
                                                    ListTile(
                                                      leading:
                                                          Icon(Icons.phone),
                                                      title: Text("Phone"),
                                                      subtitle: Text(
                                                          "${loggedInUser.mobile}"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
        ]),
      ),
    );
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
