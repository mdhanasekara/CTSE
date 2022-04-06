// ignore_for_file:  unused_import, unnecessary_import, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_new, avoid_print, unused_local_variable, unused_field, prefer_final_fields, unused_label, dead_code

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;

import 'package:CTSE/pages/lecture/custom_input_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:CTSE/colors.dart' as color;
import 'package:CTSE/pages/module-pages/notices_list.dart';
import 'package:flutter/foundation.dart';


class AddLectureDetails extends StatefulWidget {
  const AddLectureDetails({Key? key}) : super(key: key);

  @override
  State<AddLectureDetails> createState() => _AddLectureDetailsState();
}

class _AddLectureDetailsState extends State<AddLectureDetails> {

  var title = '';
  var description = '';

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

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


  // Adding lecture
  CollectionReference lectureDetails =
      FirebaseFirestore.instance.collection('lectureDetails');

 

  Future<void> addLectureDetails() {
      return lectureDetails
          .add({
            'title': title,
            'description': description,
          });
  }

  void showAlertDialog(BuildContext context) => showDialog(context: context,
    builder: (BuildContext context) { 
    return  AlertDialog(
     title: const Text('Success'),
     content: const Text('New Lecture recored successfully added.'),
     // ignore: deprecated_member_use
     actions: [OutlineButton(onPressed: () => Navigator.of(context).pop(),child: const Text('close'))]);
     },
   );

Future selectFile() async {
  final result = await FilePicker.platform.pickFiles();
  if (result == null) return;

  setState(() {
    pickedFile = result.files.first;
  });
}

Future uploadFile() async {
  final path = 'files/${pickedFile!.name}';
final file =File(pickedFile!.path!);

final ref = FirebaseStorage.instance.ref().child(path);
setState(() {
  uploadTask = ref.putFile(file);
});
final snapshot = await uploadTask!.whenComplete(() => {});

final urlDownload = await snapshot.ref.getDownloadURL();
print('Download Link: $urlDownload');

setState(() {
  uploadTask:null;
});
}
 Widget buildProgress() => StreamBuilder<TaskSnapshot>(
  stream: uploadTask ?.snapshotEvents,
  builder: (context, snapshot) {
    if(snapshot.hasData){
      final data = snapshot.data!;
      double progress = data.bytesTransferred / data.totalBytes;

       return  SizedBox(
        height:50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey,
              color: Colors.green,
            ),
            Center(child: Text(
                '${(100 * progress).roundToDouble()}%',
                style: const TextStyle(color: Colors.white),
            ),
            ),
          ]
        ),
        
        );
    }
    else{
      return  const SizedBox(height:50);
    }
  }
);

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    var add;
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
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Lecture Details",
                        style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.homePageTitle,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),

                  
                  CustomerInputBox(
                      label: 'Title',
                      inputHint: 'Title',
                      controller: titleController),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomerInputBox(
                      label: 'Description',
                      inputHint: 'Description',
                      controller: descriptionController),
                  const SizedBox(
                    height: 30,
                  ),
                   Text(
                        "",
                        style: TextStyle(
                            fontSize: 12,
                            color: color.AppColor.homePageTitle,
                            fontWeight: FontWeight.w700),
                      ),
                  ElevatedButton(onPressed: selectFile, 
                  child: const Text('Select File'),  ),
                  const SizedBox(
                    height: 30),
                 ElevatedButton(onPressed: uploadFile, 
                  child: const Text('Upload File'),  ),
                  const SizedBox(
                    height: 30),
                    
                   buildProgress(),

                  InkWell(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 38),
                        width: scrWidth * 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                            color: color.AppColor.gradientFirst,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text(
                            'Add Lecture Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          
                        )),
                    onTap: () {
                      setState(() {
                        title = titleController.text;
                        description = descriptionController.text;
                        addLectureDetails();
                        showAlertDialog(context);
                        clearText();
                      });
                    },
                  ),
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
