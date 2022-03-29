import 'package:CTSE/pages/module-pages/module_outline_list.dart';
import 'package:CTSE/pages/module-pages/notices_list.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> topics = [
      'Notices',
      'Module Outline',
      'Study Materials',
      'Profile'
    ];

    List<Color> colorsList = [
      Color.fromARGB(255, 233, 228, 187).withOpacity(0.6),
      Color.fromARGB(255, 233, 230, 235).withOpacity(0.6),
      Color.fromARGB(255, 99, 182, 247).withOpacity(0.6),
      Color.fromARGB(255, 235, 206, 204).withOpacity(0.6),
    ];

    List<String> imageList = [
      "images/notices.png",
      "images/moduleOutline.jpg",
      "images/studyMaterials.jpg",
      "images/profileBox.png",
    ];

    List<Widget> pageList = [
       NoticesList(),
       ModuleOutlineList(),
       NoticesList(),
       NoticesList(),
    ];

    return Scaffold(
        backgroundColor: color.AppColor.homePageBackground,
        body: Container(
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
                padding: const EdgeInsets.only(top: 60, left: 30),
                child: Column(children: [
                  Row(
                    children: [
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
                padding: const EdgeInsets.only(top: 150, left: 15, right: 15),
                child: Column(children: [
                  Expanded(
                      child: GridView.count(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
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
                              Text(
                                topics[i],
                                style: TextStyle(
                                    color: color.AppColor.homePageSubtitle,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Center(
                                  child: Image.asset(
                                    imageList[i],
                                    width: size.width * 0.35,
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
        ));
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
