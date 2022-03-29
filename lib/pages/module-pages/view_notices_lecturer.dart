import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;

import '../../common/theme_helper.dart';

class ViewNotices extends StatefulWidget {
  const ViewNotices({Key? key}) : super(key: key);

  @override
  State<ViewNotices> createState() => _ViewNoticesState();
}

class _ViewNoticesState extends State<ViewNotices> {
  var title = '';
  var description = '';

  final Stream<QuerySnapshot> noticesStream =
      FirebaseFirestore.instance.collection('notices').snapshots();

  CollectionReference notices =
      FirebaseFirestore.instance.collection('notices');

  // Delete
  Future<void> deleteNotice(id) {
    return notices
        .doc(id)
        .delete()
        .then((value) => print('Notice Deleted'))
        .catchError((error) => print('Failed to Delete Notice: $error'));
  }

  // Update
  Future<void> updateUser(oldTitle, oldDes, id, title, description) {
    if(title == '') title = oldTitle;
    if(description == '') title = oldDes;

    return notices
        .doc(id)
        .update({'title': title, 'description': description})
        .then((value) => print("Notice Updated"))
        .catchError((error) => print("Failed to update notice: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
        stream: noticesStream,
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
                Positioned(
                  bottom: 0,
                  child: Image.asset(
                    'images/listModuleDetails.png',
                    width: size.width * 0.7,
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 50, left: 10, right: 10, bottom: 0),
                    child: Column(
                      children: [
                        Positioned(
                          top: 0,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.homePageIcons,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Notices",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: color.AppColor.homePageTitle,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        // SingleChildScrollView(

                        for (var i = 0; i < storedocs.length; i++) ...[
                          Positioned(
                            child: Container(
                                margin: EdgeInsets.all(5),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5),
                                height: 120,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 119, 169, 209)
                                      .withOpacity(0.6),
                                  // color: color.AppColor.secondPageTopIconColor
                                  // .withOpacity(0.6),
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
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 80,
                                        ),
                                        Tooltip(
                                          message: 'Edit',
                                          child: IconButton(
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
                                                            height: 380.0,
                                                            width: 360.0,
                                                            child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  Center(
                                                                    child: Text(
                                                                      "Edit Notice",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              24,
                                                                          color: Colors
                                                                              .blue,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: TextFormField(
                                                                        style: TextStyle(fontSize: 17, color: color.AppColor.formTextColor),
                                                                        initialValue: storedocs[i]['title'],
                                                                        autofocus: false,
                                                                        onChanged: (value) => title = value,
                                                                        decoration: ThemeHelper().textInputDecoration('Title', 'Enter Title'),
                                                                        validator: (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return 'Please Enter Title';
                                                                          }
                                                                          return null;
                                                                        }),
                                                                    decoration:
                                                                        ThemeHelper()
                                                                            .inputBoxDecorationShaddow(),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: TextFormField(
                                                                        style: TextStyle(fontSize: 17, color: color.AppColor.formTextColor),
                                                                        initialValue: storedocs[i]['description'],
                                                                        autofocus: false,
                                                                        maxLines: 4,
                                                                        onChanged: (value) => description = value,
                                                                        decoration: ThemeHelper().textInputDecoration('Description', 'Enter Description'),
                                                                        validator: (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return 'Please Enter Description';
                                                                          }
                                                                          return null;
                                                                        }),
                                                                    decoration:
                                                                        ThemeHelper()
                                                                            .inputBoxDecorationShaddow(),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            updateUser(
                                                                              storedocs[i]['title'],
                                                                              storedocs[i]['description'],
                                                                                storedocs[i]['id'],
                                                                                title,
                                                                                description);
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'Edit',
                                                                            style:
                                                                                const TextStyle(fontSize: 24.0),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ])));
                                                  })
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Color.fromARGB(
                                                  255, 32, 21, 78),
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                        ),
                                        Tooltip(
                                          message: 'Delete',
                                          child: IconButton(
                                            onPressed: () => {
                                              deleteNotice(storedocs[i]['id'])
                                            },
                                            icon: Icon(Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 143, 45, 38),
                                                size: 30),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
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
