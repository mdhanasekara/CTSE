import 'package:CTSE/pages/IT19141848/admin-pages/update_student_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;

class ListUserPage extends StatefulWidget {
  ListUserPage({Key? key}) : super(key: key);

  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  // For Deleting User
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return users
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
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

          return Container(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Stack(children: [
                    Builder(
                      builder: (context) => Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 0, right: 0, bottom: 5),
                          child: Stack(children: <Widget>[
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
                              bottom: 30,
                              child: Image.asset(
                                'images/users.png',
                                width: size.width * 0.8,
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
                                    "Registered Users",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: color.AppColor.homePageTitle,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 90, left: 10, right: 10, bottom: 5),
                              child: Table(
                                border: TableBorder.all(),
                                columnWidths: const <int, TableColumnWidth>{
                                  1: FixedColumnWidth(90),
                                },
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Text(
                                              'Name',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Text(
                                              'Email  ',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Text(
                                              'Mobile',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          color: Colors.greenAccent,
                                          child: Center(
                                            child: Text(
                                              'Action',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (var i = 0;
                                      i < storedocs.length;
                                      i++) ...[
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Center(
                                              child: Text(storedocs[i]['fname'],
                                                  style: TextStyle(
                                                      fontSize: 12.0))),
                                        ),
                                        TableCell(
                                          child: Center(
                                              child: Text(storedocs[i]['email'],
                                                  style: TextStyle(
                                                      fontSize: 12.0))),
                                        ),
                                        TableCell(
                                          child: Center(
                                              child: Text(
                                                  storedocs[i]['mobile'],
                                                  style: TextStyle(
                                                      fontSize: 12.0))),
                                        ),
                                        TableCell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () => {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateStudentPage(
                                                              id: storedocs[i]
                                                                  ['id']),
                                                    ),
                                                  )
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () => {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40)),
                                                            elevation: 16,
                                                            child: Container(
                                                                height: 150.0,
                                                                width: 300.0,
                                                                child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                          height:
                                                                              20),
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          "Delete User?",
                                                                          style: TextStyle(
                                                                              fontSize: 24,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            ElevatedButton(
                                                                              onPressed: () {
                                                                                deleteUser(storedocs[i]['id']);
                                                                                Navigator.of(context, rootNavigator: true).pop();
                                                                              },
                                                                              child: const Text(
                                                                                'Delete',
                                                                                style: const TextStyle(fontSize: 24.0),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ])));
                                                      })
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            )
                          ])),
                    )
                  ])));
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
