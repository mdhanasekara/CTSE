// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:CTSE/pages/login-pages/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/common/theme_helper.dart';

class getcurrentuser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Color.fromARGB(255, 245, 245, 247),
        resizeToAvoidBottomInset: false,
        // ignore: unnecessary_new
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
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
              decoration: ThemeHelper().buttonBoxDecoration(context),
              child: ElevatedButton(
                style: ThemeHelper().buttonStyle(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ),
          ],
        ));
  }
}
