// ignore_for_file: avoid_print, sized_box_for_whitespace, unnecessary_const, avoid_unnecessary_containers
import 'package:CTSE/pages/IT19204062/drawer-pages/lecturer_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;
import '../../common/theme_helper.dart';

class ViewLectureDetails extends StatefulWidget {
  const ViewLectureDetails({Key? key}) : super(key: key);

  @override
  State<ViewLectureDetails> createState() => _ViewLectureDetails();
}

class _ViewLectureDetails extends State<ViewLectureDetails> {
  var title = '';
  var description = '';

  final Stream<QuerySnapshot> lectureStream =
      FirebaseFirestore.instance.collection('lectureDetails').snapshots();

  CollectionReference lecture =
      FirebaseFirestore.instance.collection('lectureDetails');

  // Delete
  Future<void> deleteLecture(id) {
    return lecture
        .doc(id)
        .delete()
        .then((value) => print('Lecture Details Deleted'))
        .catchError((error) => print('Failed to Delete Lecture Details: $error'));
  }

  // Update
  Future<void> updateLectureDetails(oldTitle, oldDes, id, title, description) {
    if(title == '') title = oldTitle;
    if(description == '') title = oldDes;

    return lecture
        .doc(id)
        .update({'title': title, 'description': description})
        .then((value) => print("Lecture Details Updated"))
        .catchError((error) => print("Failed to update Lecture Details: $error"));
  }

  void showAlertDialog(BuildContext context) => showDialog(context: context,
    builder: (BuildContext context) { 
    return  AlertDialog(
     title: const Text('Success'),
     content: const Text('New Lecture recored successfully edited.'),
     // ignore: deprecated_member_use
     actions: [OutlineButton(onPressed: () => Navigator.of(context).pop(),child: const Text('close'))]);
     },
   );

   void showDeleteDialog(BuildContext context) => showDialog(context: context,
    builder: (BuildContext context) { 
    return  AlertDialog(
     title: const Text('Success'),
     content: const Text('New Lecture recored successfully deleted.'),
     // ignore: deprecated_member_use
     actions: [OutlineButton(onPressed: () => Navigator.of(context).pop(),child: const Text('close'))]);
     },
   );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
        stream: lectureStream,
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
            drawer: LecturerDrawer(),
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
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                              onPressed: () => {
                                Scaffold.of(context).openDrawer()
                              },
                              icon: Icon(Icons.menu,
                                  color: color.AppColor.homePageIcons,
                                  size: 30),
                            ),
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
                          height: 35,
                        ),
                        for (var i = 0; i < storedocs.length; i++) ...[
                          Positioned(
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5),
                                height: 120,
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
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
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
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  const Center(
                                                                    child: const Text(
                                                                      "Edit Lecture Details",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              24,
                                                                          color: Colors
                                                                              .blue,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
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
                                                                  const SizedBox(
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
                                                                              value.isEmpty || value == "") {
                                                                            return 'Please Enter Description';
                                                                          }
                                                                          return null;
                                                                        }),
                                                                    decoration:
                                                                        ThemeHelper()
                                                                            .inputBoxDecorationShaddow(),
                                                                  ),
                                                                  const SizedBox(
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
                                                                            updateLectureDetails(
                                                                              storedocs[i]['title'],
                                                                              storedocs[i]['description'],
                                                                                storedocs[i]['id'],
                                                                                title,
                                                                                description);
                                                                              showAlertDialog(context);
                                                                              _ViewLectureDetails();

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
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Color.fromARGB(
                                                  255, 32, 21, 78),
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 80,
                                        ),
                                        Tooltip(
                                          message: 'Delete',
                                          child: IconButton(
                                            onPressed: () => {
                                              deleteLecture(storedocs[i]['id']),
                                              showDeleteDialog(context)

                                            },
                                            icon: const Icon(Icons.delete,
                                                color: Color.fromARGB(255, 138, 48, 41),
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
