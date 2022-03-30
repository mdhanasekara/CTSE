import 'package:CTSE/Helper.dart';
import 'package:CTSE/common/theme_helper.dart';
import 'package:CTSE/pages/add_student_page.dart';
import 'package:CTSE/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
//import 'package:my_first_flutter_project/Helper.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //final _formKey = GlobalKey<FormState>();
    AuthService authService = AuthService();
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 220, 230, 248),
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Color.fromARGB(255, 3, 28, 70),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200.0,
              width: 210.0,
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
              ),
              child: Center(child: Image.asset("images/girl.jpg")),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: authService.email,
              decoration: InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: authService.password,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              obscureText: true,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              child: const Text("Forgotten Password",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: ThemeHelper().buttonBoxDecoration(context),
              child: ElevatedButton(
                style: ThemeHelper().buttonStyle(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text(
                    "Login".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  if (authService.email != "" && authService.password != "") {
                    authService.loginUser(context);
                  }
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddStudentPage()));
                },
                child: Text(
                  "Don't Have An Account? Register",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
