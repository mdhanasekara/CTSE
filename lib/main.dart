import 'package:CTSE/pages/add_student_page.dart';
import 'package:CTSE/pages/login-pages/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/pages/splash-pages/splash_screen.dart';
import 'pages/splash-pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something went Wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'CTSE',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(
              title: 'CTSE',
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
