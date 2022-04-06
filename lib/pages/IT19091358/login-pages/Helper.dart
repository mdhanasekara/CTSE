import 'package:CTSE/common/theme_helper.dart';
import 'package:CTSE/pages/IT19141848/admin-pages/add_user_page.dart';
import 'package:CTSE/pages/IT19091358/login-pages/Login.dart';
import 'package:CTSE/pages/IT19204062/student-pages/student_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;

import '../../IT19204062/lecturer-pages/lecturer_dashboard.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    password.dispose();
  }

  void loginUser(context) async {
    try {
      print(email.text + ' - ' + password.text);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: CircularProgressIndicator(),
              ),
            );
          });
      await auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email.text)
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            print("Logged");
            if (doc["type"] == 'student') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserDashboard()));
            } else if (doc["type"] == 'lecturer') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LecturerDashboard()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddUserPage()));
            }
          });
        });
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error Message"),
              content: Text(e.toString()),
            );
          });
    }
  }
}

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController resetcontroller = TextEditingController();

    return Scaffold(
        backgroundColor: color.AppColor.homePageBackground,
        body: Container(
            padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
            child: Stack(alignment: Alignment.center, children: <Widget>[
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: resetcontroller,
                      decoration: InputDecoration(
                          labelText: "E-mail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: ThemeHelper().buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text(
                            "Reset Password".toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: resetcontroller.text)
                              .then((value) => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login())),
                                  });
                        },
                      ),
                    )
                  ],
                ),
              ),
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
