import 'package:CTSE/pages/module-pages/custom_input_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;

import '../list_student_page.dart';

class AddModuleDetails extends StatefulWidget {
  const AddModuleDetails({Key? key}) : super(key: key);

  @override
  State<AddModuleDetails> createState() => _AddModuleDetailsState();
}

class _AddModuleDetailsState extends State<AddModuleDetails> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = 'Please choose the detail type';

  var title = '';
  var description = '';

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  clearText() {
    titleController.clear();
    descriptionController.clear();
  }

  // Adding Student
  CollectionReference moduleOutlineDetails =
      FirebaseFirestore.instance.collection('moduleOutlineDetails');

  CollectionReference notices =
      FirebaseFirestore.instance.collection('notices');

  Future<void> addModuleDetails() {
    if (selectedValue == 'Module Outline Details') {
      return moduleOutlineDetails
          .add({
            'title': title,
            'description': description,
          })
          .then((value) => print('Module Details Added'))
          .catchError((error) => print('Failed to Add Module details: $error'));
    } else {
      print('hi');
      return notices
          .add({
            'title': title,
            'description': description,
          })
          .then((value) => print('Module Details Added'))
          .catchError((error) => print('Failed to Add Module details: $error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 25),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
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
              right: 0,
              child: Image.asset(
                'images/module.jpg',
                width: size.width * 0.7,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: Column(children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: color.AppColor.homePageIcons,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Module Details",
                        style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.homePageTitle,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),

                  DropdownButtonFormField<String>(
                    hint: Text('Please choose the detail type'),
                    value: selectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: <String>[
                      'Please choose the detail type',
                      'Notices',
                      'Module Outline Details'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27),
                        borderSide: BorderSide(
                          color: color.AppColor.gradientFirst,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomerInputBox(
                      label: 'Title',
                      inputHint: 'Title',
                      controller: titleController),
                  SizedBox(
                    height: 30,
                  ),
                  CustomerInputBox(
                      label: 'Description',
                      inputHint: 'Description',
                      controller: descriptionController),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 38),
                        width: scrWidth * 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                            color: color.AppColor.gradientFirst,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Add Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    onTap: () {
                      // if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ListStudentPage()),
                          (Route<dynamic> route) => false);
                      setState(() {
                        title = titleController.text;
                        description = descriptionController.text;
                        addModuleDetails();
                        clearText();
                      });
                      // }
                    },
                  ),
                  // ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
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
