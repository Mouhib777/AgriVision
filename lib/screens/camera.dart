import 'dart:io';
import 'dart:math';

import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/model/tfliteModel.dart';
import 'package:agri_vision/screens/homeScreen.dart';
import 'package:agri_vision/screens/lemon.dart';
import 'package:agri_vision/screens/olive.dart';
import 'package:agri_vision/screens/palm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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
String? _posting;
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
    // _checkPermissionStatus();
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
    // _requestPermissionCamera();
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
    // _requestPermissionGallery();
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
                                  // color: Color.fromARGB(164, 76, 175, 79),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(_pickedImage!),
                                  ),
                                ),
                              ),
                            ),
                            onLongPress: () {
                              handle_image_gallery();
                            },
                            onTap: () {
                              if (_treeType == 'palm') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => palmScreen(
                                        image: _pickedImage,
                                      ),
                                    ));
                              } else if (_treeType == 'olive') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => oliveScreen(),
                                    ));
                              } else if (_treeType == 'lemon') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => lemonSCreen(),
                                    ));
                              }
                            },
                          )),
              ),
              SizedBox(
                height: 20,
              ),
              _pickedImage != null
                  ? Row(
                      children: [
                        Text(
                          '$_treeType' == 'null'
                              ? 'Add a picture to recognize'
                              : 'Recognized tree: $_treeType',
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("More info")
                      ],
                    )
                  : Text(""),
              SizedBox(
                height: 20,
              ),
              _pickedImage != null
                  ? Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          _posting = value;
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Got any thing on your mind?',
                          hintStyle: GoogleFonts.raleway(
                            letterSpacing: 1,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        // _requestPermissionCamera();
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
                        backgroundColor: primaryColor,
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
                        Timestamp timestamp = Timestamp.now();
                        String dateString = timestamp.toDate().toString();

                        await FirebaseFirestore.instance
                            .collection('posts')
                            .doc()
                            .set({
                          "name": user_data['full name'],
                          "id": _uid,
                          "imageUrl": '$imageUrl',
                          "writing": " $_posting",
                          "likes": 0,
                          "date": dateString
                        });
                        if ('$_treeType' == 'palm') {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(_uid)
                              .collection('historique')
                              .doc()
                              .set({
                            // "name": user_data['full name'],
                            // "id": _uid,
                            "weather": "hot",
                            "size": "23m",
                            "age": "1000y",
                            "water": "100l/w",
                            "sun": "bright",
                            "treetype": "Palm",
                            "description":
                                "Date Palm is a symbol of the oasis culture in Tunisia. It's a tall, elegant tree with long, feather-like leaves that provide shade and beauty. The fruit of the Date Palm is a staple food in Tunisia, and is often used in cooking and baking. The Date Palm has significant cultural and economic importance in Tunisia, as it is both a source of food and a valuable export.",
                            "imageUrl": '$imageUrl',
                            "writing": " $_posting",
                            "date": dateString
                          });
                        } else if ('$_treeType' == 'olive') {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(_uid)
                              .collection('historique')
                              .doc()
                              .set({
                            "weather": "Warm",
                            "size": "15m",
                            "age": "2000y",
                            "water": "25l/w",
                            "treetype": "Olive",
                            "description":
                                "The Olive Tree is an iconic symbol of the Mediterranean region and is one of the oldest cultivated trees in the world. In Tunisia, Olive Trees are widely grown for their fruit, which is used to produce high-quality olive oil, a staple ingredient in Tunisian cuisine. The trees have a twisted, gnarled appearance and silvery-green leaves that add beauty to the landscape.",
                            "imageUrl": '$imageUrl',
                            "writing": " $_posting",
                            "date": dateString
                          });
                        } else if ('$_treeType' == 'lemon') {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(_uid)
                              .collection('historique')
                              .doc()
                              .set({
                            "weather": "Warm",
                            "size": "6m",
                            "age": "50y",
                            "water": "50l/w",
                            "treetype": "Lemon",
                            "description":
                                "Lemon Tree is a small, evergreen tree with glossy leaves and fragrant white flowers. The fruit of the Lemon Tree is prized for its sour, acidic flavor, and is used in cooking, baking, and beverages. Lemon trees are a popular choice for home gardens in Tunisia, and are also cultivated for commercial purposes",
                            "imageUrl": '$imageUrl',
                            "writing": " $_posting",
                            "date": dateString
                          });
                        }
                        pushNewScreenWithRouteSettings(context,
                            screen: homeScreen(),
                            settings: RouteSettings(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino);
                      },
                    )
                  : ElevatedButton(
                      onPressed: () {
                        // _requestPermissionGallery();
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

  // PermissionStatus? _permissionStatus;

  // Future<void> _checkPermissionStatus() async {
  //   PermissionStatus status = await Permission.camera.status;
  //   setState(() {
  //     _permissionStatus = status;
  //   });
  // }

  // Future<void> _requestPermissionCamera() async {
  //   PermissionStatus status = await Permission.camera.request();
  //   setState(() {
  //     _permissionStatus = status;
  //   });
  // }

  // Future<void> _requestPermissionGallery() async {
  //   PermissionStatus status = await Permission.storage.request();
  //   setState(() {
  //     _permissionStatus = status;
  //   });
  // }

  Future recognizeImage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: _pickedImage!.path,
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
