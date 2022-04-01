import 'package:CTSE/common/theme_helper.dart';
import 'package:CTSE/getcurrentuser.dart';
import 'package:CTSE/login.dart';
import 'package:CTSE/login_teacher.dart';
import 'package:CTSE/pages/add_student_page.dart';
import 'package:CTSE/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  //late BuildContext context;

  void loginUser(context) async {
    try {
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
        print("Logged");
        if (email.text == "nethmi981@gmail.com" ||
            email.text == "vajira@gmail.com") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => getcurrentuser()));
        } else if (email.text == "ajantha@gmail.com" &&
                password.text == "ajantha" ||
            email.text == "kushani@gmail.com") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Teacher()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddStudentPage()));
        }
        //want to change
      });
      //

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
