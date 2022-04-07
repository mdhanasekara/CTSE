import 'package:CTSE/common/theme_helper.dart';
import 'package:CTSE/pages/IT19204062/drawer-pages/lecturer_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;
import 'package:fluttertoast/fluttertoast.dart';

class AddModuleDetails extends StatefulWidget {
  const AddModuleDetails({Key? key}) : super(key: key);

  @override
  State<AddModuleDetails> createState() => _AddModuleDetailsState();
}

class _AddModuleDetailsState extends State<AddModuleDetails> {
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
      drawer: LecturerDrawer(),
      backgroundColor: color.AppColor.homePageBackground,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Builder(
              builder: (context) => Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 0, right: 0, bottom: 5),
                child: Stack(
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
                      right: size.width * 0.2,
                      bottom: 0,
                      child: Image.asset(
                        'images/module.jpg',
                        width: size.width * 0.7,
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () =>
                                {Scaffold.of(context).openDrawer()},
                            icon: Icon(Icons.menu,
                                color: color.AppColor.homePageIcons, size: 30),
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
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(25, 120, 25, 10),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                child: DropdownButtonFormField<String>(
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
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: TextFormField(
                                    controller: titleController,
                                    autofocus: false,
                                    decoration: ThemeHelper()
                                        .textInputDecoration(
                                            'Title', 'Enter title'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Title';
                                      }
                                      return null;
                                    }),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: descriptionController,
                                  autofocus: false,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Description", "Enter description"),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please description';
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "Add Details",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      title = titleController.text;
                                      description = descriptionController.text;
                                      addModuleDetails();
                                      clearText();
                                      Fluttertoast.showToast(
                                          msg: "Module Detail Added",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Color.fromARGB(255, 61, 59, 59),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
