import 'package:CTSE/pages/IT19056258/add_lecture_details.dart';
import 'package:CTSE/pages/IT19056258/amin_view_lecture_details.dart';
import 'package:CTSE/pages/IT19141848/user-pages/user_profile.dart';
import 'package:CTSE/pages/IT19204062/drawer-pages/lecturer_drawer.dart';
import 'package:CTSE/pages/IT19204062/lecturer-pages/view_notices_lecturer.dart';
import 'package:CTSE/pages/IT19204062/lecturer-pages/view_outline_lecturer.dart';
import 'package:CTSE/pages/IT19204062/lecturer-pages/add_module_details.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;

class LecturerDashboard extends StatelessWidget {
  const LecturerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> topics = [
      'View Notices',
      'View Module Outline',
      'Add Module Details',
      'View Study Materials',
      'Add Study Materials',
      'Profile',
    ];

    List<Color> colorsList = [
      Color.fromARGB(255, 185, 240, 201).withOpacity(0.6),
      Color.fromARGB(255, 252, 208, 151).withOpacity(0.6),
      Color.fromARGB(255, 235, 208, 220).withOpacity(0.6),
      Color.fromARGB(255, 202, 226, 241).withOpacity(0.6),
      Color.fromARGB(255, 238, 237, 237).withOpacity(0.6),
      Color.fromARGB(255, 150, 172, 235).withOpacity(0.6),
    ];

    List<String> imageList = [
      "images/Lnote.png",
      "images/LModuleO.png",
      "images/LAddMD.png",
      "images/LStudyM.png",
      "images/LAddStudy.png",
      "images/LProfile.png",
    ];

    List<Widget> pageList = [
      const ViewNotices(),
      const ViewModuleOutline(),
      const AddModuleDetails(),
      const ViewLectureDetails(),
      const AddLectureDetails(),
      ProfilePage(),
    ];

    return Scaffold(
      drawer: LecturerDrawer(),
        backgroundColor: color.AppColor.homePageBackground,
        body: Builder(builder:(context) =>  
        Container(
          padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
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
              Container(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                              onPressed: () => {
                                Scaffold.of(context).openDrawer()
                              },
                              icon: Icon(Icons.menu,
                                  color: color.AppColor.homePageIcons,
                                  size: 30),
                            ),
                      Text(
                        "Dashboard",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.homePageTitle,
                        ),
                      )
                    ],
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(top: 55, left: 15, right: 15),
                child: Column(children: [
                  Expanded(
                      child: GridView.count(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 18,
                    crossAxisCount: 2,
                    children: [
                      for (var i = 0; i < topics.length; i++) ...[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => pageList[i],
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: colorsList[i],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(children: [
                              Center(child: 
                              Text(
                                topics[i],
                                style: TextStyle(
                                    color: color.AppColor.homePageSubtitle,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              )),
                              SizedBox(
                                height: 15,
                              ),
                              Row(children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Center(
                                  child: Image.asset(
                                    imageList[i],
                                    width: size.width * 0.3,
                                  ),
                                ),
                              ]),
                            ]),
                          ),
                        ),
                      ]
                    ],
                  ))
                ]),
              )
            ],
          ),
        )));
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
