import 'dart:io';

import 'package:agri_vision/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class cameraScreen extends StatefulWidget {
  const cameraScreen({super.key});

  @override
  State<cameraScreen> createState() => _cameraScreenState();
}

final ImagePicker _picker = ImagePicker();
ImagePicker? imagePicker;
File? _pickedImage;
String? imageUrl;

class _cameraScreenState extends State<cameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                handle_image_camera();
              },
              child: Text(
                "From camera",
                style: GoogleFonts.montserrat(letterSpacing: 2),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                handle_image_gallery();
              },
              child: Text(
                "From gallery",
                style: GoogleFonts.montserrat(letterSpacing: 2),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            )
          ],
        ),
      ),
    );
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
}
