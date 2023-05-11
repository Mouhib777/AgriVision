import 'dart:io';
import 'dart:math';

import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/navBar/navBar.dart';
import 'package:agri_vision/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class postingScreen extends StatefulWidget {
  const postingScreen({super.key});

  @override
  State<postingScreen> createState() => _postingScreenState();
}

class _postingScreenState extends State<postingScreen> {
  final ImagePicker _picker = ImagePicker();
  ImagePicker? imagePicker;
  File? _pickedImage;
  String? imageUrl;
  List? _recognitions;
  String? _treeType;
  String? _posting;
  final Random _random = Random();

  String generateRandomName(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  handle_image_camera() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    _pickedImage = File(pickedFile!.path);

    if (_pickedImage != null) {
      setState(() {
        _pickedImage;
      });
    } else {
      EasyLoading.showError('No image selected');
    }
  }

  handle_image_gallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    _pickedImage = File(pickedFile!.path);

    if (_pickedImage != null) {
      setState(() {
        _pickedImage;
      });
    } else {
      EasyLoading.showError('No image selected');
    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Text(''),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70),
                topRight: Radius.circular(70),
              ),
              color: Colors.white,
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            child: Text(
                              "Back",
                              style: GoogleFonts.montserratAlternates(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 280,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey, width: 0.3)),
                        child: TextFormField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: "Got anything on your mind?",
                            hintStyle: GoogleFonts.raleway(
                                letterSpacing: 3,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        child: Container(
                          height: 230,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffC4C4C4),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Image.asset(
                                "assets/images/icons/gallery.png",
                                color: Colors.white,
                              )),
                        ),
                        onTap: () {
                          handle_image_gallery();
                        },
                        onLongPress: () {
                          handle_image_camera();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Post",
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          child:
                              _isLoading ? CircularProgressIndicator() : null),
                    ])),
          ))
        ])));
  }
}
