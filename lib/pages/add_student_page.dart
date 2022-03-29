import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/common/theme_helper.dart';
import 'package:CTSE/pages/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'home_page.dart';
import 'widgets/header_widget.dart';

class AddStudentPage extends StatefulWidget {
  AddStudentPage({Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final double _headerHeight = 250;
  String selectedValue = 'Please choose the user type';

  var fname = "";
  var lname = "";
  var email = "";
  var mobile = "";
  var password = "";
  var status = "";
  bool checkedValue = false;
  bool checkboxValue = false;
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    statusController.dispose();
    super.dispose();
  }

  clearText() {
    fnameController.clear();
    lnameController.clear();
    emailController.clear();
    mobileController.clear();
    passwordController.clear();
    statusController.clear();
  }

  // Adding Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> addUser() {
    return students
        .add({
          'fname': fname,
          'lname': lname,
          'email': email,
          'mobile': mobile,
          'password': password,
          //'status': status,
          'type': selectedValue,
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  Widget buildImageCard() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(
                'http://blog.travelpayouts.com/en/wp-content/uploads/sites/2/2019/08/content-creation.jpg',
              ),
              child: InkWell(
                onTap: () {},
              ),
              height: 160,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Course Registration"),
      // ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, false,
                  Icons.login_rounded), //let's create a common header widget
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  buildImageCard(),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                              controller: fnameController,
                              autofocus: false,
                              decoration: ThemeHelper().textInputDecoration(
                                  'First Name', 'Enter your first name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter First Name';
                                }
                                return null;
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                              controller: lnameController,
                              autofocus: false,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Last Name', 'Enter your last name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Last Name';
                                }
                                return null;
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            autofocus: false,
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: TextFormField(
                            controller: mobileController,
                            autofocus: false,
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number", "Enter your mobile number"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: TextFormField(
                            controller: passwordController,
                            autofocus: false,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Column(children: [
                            DropdownButtonFormField<String>(
                              hint: Text('Please choose the user type'),
                              value: selectedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Please choose the user type',
                                'student',
                                'lecturer'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(70),
                                  borderSide: BorderSide(
                                      //color: color.AppColor.gradientFirst,
                                      ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(70),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (Route<dynamic> route) => false);
                                setState(() {
                                  fname = fnameController.text;
                                  lname = lnameController.text;
                                  email = emailController.text;
                                  mobile = mobileController.text;
                                  password = passwordController.text;
                                  addUser();
                                  clearText();
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Or create account using social media",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus,
                                size: 35,
                                color: HexColor("#EC2D2F"),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Google Plus",
                                          "You tap on GooglePlus social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: HexColor("#40ABF0")),
                                  color: HexColor("#40ABF0"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.twitter,
                                  size: 23,
                                  color: HexColor("#FFFFFF"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Twitter",
                                          "You tap on Twitter social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                size: 35,
                                color: HexColor("#3E529C"),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Facebook",
                                          "You tap on Facebook social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
