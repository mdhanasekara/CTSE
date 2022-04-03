import 'package:CTSE/common/theme_helper.dart';
import 'package:CTSE/getcurrentuser.dart';
import 'package:CTSE/login_teacher.dart';
import 'package:CTSE/pages/add_student_page.dart';
import 'package:CTSE/pages/home_page.dart';
import 'package:CTSE/pages/login-pages/Login.dart';
import 'package:CTSE/pages/module-pages/lecturer_dashboard.dart';
import 'package:CTSE/pages/module-pages/user_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  //late BuildContext context;

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
            print(doc["type"]);
            print(email.text);
            print("Logged");
            if (doc["type"] == 'student') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserDashboard()));
            } else if (doc["type"] == 'lecturer') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LecturerDashboard()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudentPage()));
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
    TextEditingController resetcontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Your Password"),
      ),
      body: Padding(
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
                      .sendPasswordResetEmail(email: resetcontroller.text)
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
    );
  }
}
