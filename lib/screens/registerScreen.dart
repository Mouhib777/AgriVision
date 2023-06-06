import 'dart:io';
import 'dart:math';

import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/navBar/navBar.dart';
import 'package:agri_vision/screens/additional/termsScreen.dart';
import 'package:agri_vision/screens/loginScreen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  bool _acceptedTerms = false;
  String? email;
  String? f_name;
  String? password;
  String? p_confirm;
  var _fNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  ImagePicker? imagePicker;
  File? _pickedImage;
  String? imageUrl;

  final Random _random = Random();

  String generateRandomName(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: Text(
              "AgriVision",
              style: GoogleFonts.montserratAlternates(
                  color: primaryColor,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  fontSize: 26),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Let's sign you up",
                      style: GoogleFonts.montserratAlternates(
                          fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Welcome aboard, we hope you enjoy your\ntime with us",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    var alertStyle = AlertStyle(
                      overlayColor: Colors.green,
                      animationType: AnimationType.shrink,
                      isCloseButton: false,
                      isOverlayTapDismiss: false,
                      descStyle: GoogleFonts.montserrat(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      animationDuration: Duration(milliseconds: 400),
                      alertBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(
                          color: primaryColor,
                        ),
                      ),
                      titleStyle: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    );

                    Alert(
                      context: context,
                      style: alertStyle,
                      type: AlertType.none,
                      title: "Add picture for your profile",
                      buttons: [
                        DialogButton(
                          child: Icon(
                            Icons.drive_folder_upload,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            handle_image_gallery();
                            Navigator.pop(context);
                          },
                          color: primaryColor,
                          radius: BorderRadius.circular(10.0),
                        ),
                        DialogButton(
                          child: Icon(
                            CupertinoIcons.camera,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            handle_image_camera();
                            Navigator.pop(context);
                          },
                          color: primaryColor,
                          radius: BorderRadius.circular(10.0),
                        ),
                      ],
                    ).show();
                  },
                  child: SizedBox(
                      height: 200,
                      // width: 270,
                      child: Card(
                          shape: CircleBorder(),
                          child: ClipRRect(
                              child: _pickedImage == null
                                  ? Center(
                                      child: Text(
                                        'Add Your Picture',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 90,
                                      backgroundImage: FileImage(_pickedImage!),
                                    )))),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Create your account",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: _fNameController,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.montserrat(),
                      labelStyle: GoogleFonts.montserrat(),
                      counterStyle: GoogleFonts.montserrat(),
                      hintText: 'Full name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: '  Full name',
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      } else {
                        setState(() {
                          f_name = value;
                        });
                        return null;
                      }
                    },
                    onChanged: (value) {
                      f_name = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.montserrat(),
                      labelStyle: GoogleFonts.montserrat(),
                      counterStyle: GoogleFonts.montserrat(),
                      hintText: 'address@mail.com',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: '  E-mail address',
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else {
                        setState(() {
                          email = value;
                        });
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.montserrat(),
                      labelStyle: GoogleFonts.montserrat(),
                      counterStyle: GoogleFonts.montserrat(),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: '  Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else {
                        setState(() {
                          password = value;
                        });
                        return null;
                      }
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: _obscureText,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: _confirmController,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.montserrat(),
                      labelStyle: GoogleFonts.montserrat(),
                      counterStyle: GoogleFonts.montserrat(),
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: '  Confirm Password',
                    ),
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password not confirmed';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      } else {
                        setState(() {
                          p_confirm = value;
                        });
                        return null;
                      }
                    },
                    onChanged: (value) {
                      p_confirm = value;
                    },
                    obscureText: true,
                  ),
                ),
                CheckboxListTile(
                  title: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'I agree to ',
                            style: GoogleFonts.montserratAlternates(
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            child: Text(
                              "the terms and conditions",
                              style: GoogleFonts.montserratAlternates(
                                  fontSize: 14, color: primaryColor),
                            ),
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration: Duration.zero,
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      termsScreen()));
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'of AgriVision',
                            style: GoogleFonts.montserratAlternates(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  value: _acceptedTerms,
                  onChanged: (newValue) {
                    setState(() {
                      _acceptedTerms = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 350,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _acceptedTerms
                        ? () async {
                            var _token = await _firebaseMessaging.getToken();
                            if (_formKey.currentState!.validate()) {
                              try {
                                if (_pickedImage == null) {
                                  EasyLoading.showError('7ot taswira');
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final ref = FirebaseStorage.instance
                                      .ref()
                                      .child('profile_picture')
                                      .child(generateRandomName(10) + '.jpg');
                                  await ref.putFile(_pickedImage!);
                                  imageUrl = await ref.getDownloadURL();
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email!.trim(),
                                          password: password!.trim());

                                  final User? userr =
                                      FirebaseAuth.instance.currentUser;
                                  final _uid = userr!.uid;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(_uid)
                                      .set({
                                    "full name": "$f_name",
                                    "email": "$email",
                                    "password": "$password",
                                    "premium": false,
                                    "plan": "Basic plan",
                                    "image": imageUrl.toString(),
                                    "deviceToken": _token,
                                    "id": _uid,
                                    "isAdmin": "false"
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => navBar(),
                                      ));

                                  EasyLoading.showSuccess(
                                      'user with name $f_name was created');
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  AnimatedSnackBar.material(
                                    "Invalid password",
                                    type: AnimatedSnackBarType.error,
                                    duration: Duration(seconds: 4),
                                    mobileSnackBarPosition:
                                        MobileSnackBarPosition.bottom,
                                  ).show(context);
                                } else if (e.code == 'invalid-email') {
                                  AnimatedSnackBar.material(
                                    "Invalid email address",
                                    type: AnimatedSnackBarType.error,
                                    duration: Duration(seconds: 4),
                                    mobileSnackBarPosition:
                                        MobileSnackBarPosition.bottom,
                                  ).show(context);
                                } else if (e.code == 'email-already-in-use') {
                                  AnimatedSnackBar.material(
                                    "This email address is already in use",
                                    type: AnimatedSnackBarType.error,
                                    duration: Duration(seconds: 4),
                                    mobileSnackBarPosition:
                                        MobileSnackBarPosition.bottom,
                                  ).show(context);
                                }
                              } catch (ex) {
                                print(ex);
                              }
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        : null,
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
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
                    child: _isLoading ? CircularProgressIndicator() : null),
                SizedBox(
                  height: 20,
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1900),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.montserratAlternates(
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "Login here",
                          style: GoogleFonts.montserratAlternates(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration: Duration.zero,
                              pageBuilder: (context, animation, secondary) =>
                                  loginScreen()));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ])))),
    );
  }

  handle_image_camera() async {
    // _requestPermissionCamera();
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
