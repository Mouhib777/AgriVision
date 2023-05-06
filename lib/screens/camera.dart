import 'dart:io';

import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/model/tfliteModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class cameraScreen extends StatefulWidget {
  const cameraScreen({super.key});

  @override
  State<cameraScreen> createState() => _cameraScreenState();
}

final ImagePicker _picker = ImagePicker();
ImagePicker? imagePicker;
File? _pickedImage;
String? imageUrl;
List? _recognitions;

class _cameraScreenState extends State<cameraScreen> {
  @override
  void initState() {
    super.initState();
    TreeRecognition.loadModel();
  }

  @override
  void dispose() {
    TreeRecognition.disposeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.61,
                width: MediaQuery.of(context).size.width,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: _pickedImage == null
                        ? Center(
                            child: Text(
                              'Add a picture to recognize',
                              style: GoogleFonts.montserrat(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : InkWell(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.598,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: primaryColor,
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: FileImage(_pickedImage!),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              recognizeImage(_pickedImage!);
                            },
                          )),
              ),
              SizedBox(
                height: 50,
              ),
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
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
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

  Future recognizeImage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }
//   var recognitions = await Tflite.runModelOnImage(
//   path: _pickedImage!.path,   // required
//   imageMean: 0.0,   // defaults to 117.0
//   imageStd: 255.0,  // defaults to 1.0
//   numResults: 2,    // defaults to 5
//   threshold: 0.2,   // defaults to 0.1
//   asynch: true      // defaults to true
// );
}
