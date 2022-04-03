// ignore_for_file: avoid_print, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;
import '../widgets/admin_lecture_drawer.dart';

class ListLecturePage extends StatefulWidget {
  const ListLecturePage({Key? key}) : super(key: key);

  @override
  State<ListLecturePage> createState() => _ListLecturePageState();
}

class _ListLecturePageState extends State<ListLecturePage> {
  final Stream<QuerySnapshot> outlineStream =
      FirebaseFirestore.instance.collection('lectureDetails').snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
        stream: outlineStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Scaffold(
            drawer: AdminLectureNavigationDrawer(),
            backgroundColor: color.AppColor.homePageBackground,
            body: Builder(builder:(context) =>  
            Container(
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
                // child:
                Container(
                  padding: const EdgeInsets.only(
                      top: 50, left: 10, right: 10, bottom: 0),
                  child: Column(
                    children: [
                      Positioned(
                        top: 0,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                           
                            Text(
                              "Lecture Details",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: color.AppColor.homePageTitle,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      for (var i = 0; i < storedocs.length; i++) ...[
                        Expanded(
                          child: Positioned(
                            top: 20,
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5),
                                height: 100,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 119, 169, 209)
                                      .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          storedocs[i]['title'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  color.AppColor.gradientFirst,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ]),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              storedocs[i]['description'],
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ],
                  ),
                ),
              ]),
            ),
          ));
        });
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