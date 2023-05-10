import 'dart:io';
import 'dart:math';

import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/model/tfliteModel.dart';
import 'package:agri_vision/screens/palm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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
String? _treeType;
final Random _random = Random();

String generateRandomName(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
}

class _cameraScreenState extends State<cameraScreen> {
  @override
  void initState() {
    super.initState();
    TreeRecognition.loadModel();
    getUser_Data();
    _checkPermissionStatus();
  }

  @override
  void dispose() {
    TreeRecognition.disposeModel();
    super.dispose();
  }

  var user_data;

  Future<DocumentSnapshot> getUser_Data() async {
    final User? user1 = FirebaseAuth.instance.currentUser;
    String? _uid = user1!.uid;
    var result1 =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      user_data = result1;
    });
    return result1;
  }

  handle_image_camera() async {
    _requestPermissionCamera();
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    _pickedImage = File(pickedFile!.path);

    if (_pickedImage != null) {
      setState(() {
        _pickedImage;
      });
      final treeType = await TreeRecognition.recognizeTree(_pickedImage!);
      setState(() {
        _treeType = treeType;
      });
    } else {
      EasyLoading.showError('No image selected');
    }
  }

  handle_image_gallery() async {
    _requestPermissionGallery();
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    _pickedImage = File(pickedFile!.path);

    if (_pickedImage != null) {
      setState(() {
        _pickedImage;
      });
      final treeType = await TreeRecognition.recognizeTree(_pickedImage!);
      setState(() {
        _treeType = treeType;
      });
    } else {
      EasyLoading.showError('No image selected');
    }
  }

  PermissionStatus? _permissionStatus;

  Future<void> _checkPermissionStatus() async {
    PermissionStatus status = await Permission.camera.status;
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _requestPermissionCamera() async {
    PermissionStatus status = await Permission.camera.request();
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _requestPermissionGallery() async {
    PermissionStatus status = await Permission.storage.request();
    setState(() {
      _permissionStatus = status;
    });
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
                                  color: Color.fromARGB(164, 76, 175, 79),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(_pickedImage!),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (_treeType == 'palm') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => palmScreen(),
                                    ));
                              } else if (_treeType == 'olive') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => palmScreen(),
                                    ));
                              } else if (_treeType == 'lemon') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => palmScreen(),
                                    ));
                              }
                            },
                          )),
              ),
              SizedBox(
                height: 20,
              ),
              _pickedImage != null
                  ? Text("")
                  : Text(
                      '$_treeType' == 'null'
                          ? 'Add a picture to recognize'
                          : 'Recognized tree: $_treeType',
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
              SizedBox(
                height: 20,
              ),
              _pickedImage != null
                  ? Text("")
                  : ElevatedButton(
                      onPressed: () {
                        _requestPermissionCamera();
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
              _pickedImage != null
                  ? ElevatedButton(
                      child: Text(
                        "Let everyone discover it",
                        style: GoogleFonts.montserratAlternates(),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      onPressed: () async {
                        final User? userr = FirebaseAuth.instance.currentUser;
                        final _uid = userr!.uid;
                        final randomName = generateRandomName(10);
                        final ref = FirebaseStorage.instance
                            .ref()
                            .child('posts')
                            .child(randomName + '.jpg');
                        await ref.putFile(_pickedImage!);
                        imageUrl = await ref.getDownloadURL();
                        print(imageUrl);
                        await FirebaseFirestore.instance
                            .collection('posts')
                            .doc()
                            .set({
                          "name": user_data['full name'],
                          "id": _uid,
                          "imageUrl": '$imageUrl'
                        });
                      },
                    )
                  : ElevatedButton(
                      onPressed: () {
                        _requestPermissionGallery();
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
