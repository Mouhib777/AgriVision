import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/navBar/navBar.dart';
import 'package:agri_vision/screens/loginScreen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    FadeIn(
                      delay: Duration(milliseconds: 500),
                      child: Text(
                        "Let's sign you up",
                        style: GoogleFonts.montserratAlternates(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
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
                    FadeIn(
                      delay: Duration(milliseconds: 700),
                      child: Text(
                        "Welcome aboard, we hope you enjoy your\ntime with us",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
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
                    FadeIn(
                      delay: Duration(milliseconds: 1000),
                      child: Text(
                        "Sign up using",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: Image.asset(
                          "assets/images/facebook.png",
                          height: 40,
                        ),
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        child: Image.asset(
                          "assets/images/google.png",
                          height: 40,
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    FadeIn(
                      delay: Duration(milliseconds: 1200),
                      child: Text(
                        "Or create your account",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1300),
                  child: SizedBox(
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
                ),
                SizedBox(
                  height: 20,
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1400),
                  child: SizedBox(
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
                ),
                SizedBox(
                  height: 20,
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1500),
                  child: SizedBox(
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
                ),
                SizedBox(
                  height: 20,
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1600),
                  child: SizedBox(
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
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1700),
                  child: CheckboxListTile(
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
                              onTap: () {},
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
                ),
                SizedBox(
                  height: 10,
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1800),
                  child: SizedBox(
                    width: 350,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _acceptedTerms
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  UserCredential user = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                          email: email!.trim(),
                                          password: password!.trim());
                                  final User? userr =
                                      FirebaseAuth.instance.currentUser;
                                  final _uid = userr!.uid;
                                  await FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(_uid)
                                      .set({
                                    "full name": "$f_name",
                                    "email": "$email",
                                    "password": "$password"
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => navBar(),
                                      ));

                                  EasyLoading.showSuccess(
                                      'user with name $f_name was created');
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
}
