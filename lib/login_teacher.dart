import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:my_first_flutter_project/Helper.dart';

class Teacher extends StatelessWidget {
  const Teacher({Key? key}) : super(key: key);

  // This widget is the root of your application.

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
      body: Center(
        child: Text('${currentEmail}'),
      ),
    );
  }
}
