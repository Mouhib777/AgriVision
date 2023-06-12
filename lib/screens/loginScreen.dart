import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/navBar/navBar.dart';
import 'package:agri_vision/screens/additional/resetpassword.dart';

import 'package:agri_vision/screens/registerScreen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  String? email;
  String? f_name;
  String? password;
  String? p_confirm;

  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: FadeIn(
          child: Text(
            "AgriVision",
            style: GoogleFonts.montserratAlternates(
                color: primaryColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
                fontSize: 26),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Center(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            FadeInLeft(
              child: Text(
                "Let's sign in",
                style: GoogleFonts.montserratAlternates(
                    fontSize: 34, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            FadeInLeft(
              child: Text(
                "We’re waiting for you to sign in again and\nstart your journey with us",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        FadeInUp(
          child: SizedBox(
              child: Column(children: [
            SizedBox(
              width: 330,
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.montserrat(),
                  labelStyle: GoogleFonts.montserrat(),
                  counterStyle: GoogleFonts.montserrat(),
                  hintText: 'address@mail.com',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: '  E-mail address',
                  // counterText:
                  //     '*Please use a verified e-mail',
                ),
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                maxLength: 40,
                onChanged: (value) {
                  email = value;
                },
                // ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 333,
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  hintStyle: GoogleFonts.montserrat(),
                  labelStyle: GoogleFonts.montserrat(),
                  counterStyle: GoogleFonts.montserrat(),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: '  Password',
                ),
                autofocus: false,

                maxLength: 40,
                onChanged: (value) {
                  password = value;
                },
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

                obscureText: _obscureText,

                // ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ResetPassword()));
                  },
                  child: Text(
                    "Forgot your password?",
                    style: GoogleFonts.montserrat(color: primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    setState(() {
                      _isLoading = true;
                    });
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email!.trim(), password: password!.trim());

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => navBar(),
                        ));
                  } on FirebaseAuthException catch (ex) {
                    if (ex.code == 'user-not-found') {
                      AnimatedSnackBar.material(
                        "No user found with this email",
                        type: AnimatedSnackBarType.error,
                        duration: Duration(seconds: 4),
                        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                      ).show(context);
                    } else if (ex.code == 'wrong-password') {
                      AnimatedSnackBar.material(
                        'Incorrect password',
                        type: AnimatedSnackBarType.error,
                        duration: Duration(seconds: 6),
                        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                      ).show(context);
                    } else if (ex.code == 'invalid-email') {
                      AnimatedSnackBar.material(
                        'Invalid email address',
                        type: AnimatedSnackBarType.error,
                        duration: Duration(seconds: 4),
                        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                      ).show(context);
                    }
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: Text(
                  "Login",
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
            SizedBox(child: _isLoading ? CircularProgressIndicator() : null),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No account yet?',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Text(
                    "Create an account",
                    style: GoogleFonts.montserrat(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondary) =>
                            registerScreen()));
                  },
                )
              ],
            ),
          ])),
        ),
        SizedBox(
          height: 30,
        ),
        // FadeIn(
        //   delay: Duration(milliseconds: 1500),
        //   child: SizedBox(
        //     child: Column(
        //       children: [
        //         Text(
        //           'Or continue with',
        //           style: GoogleFonts.montserrat(
        //               fontSize: 15, fontWeight: FontWeight.w400),
        //         ),
        //         SizedBox(
        //           height: 30,
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             InkWell(
        //               child: Image.asset(
        //                 "assets/images/facebook.png",
        //                 height: 40,
        //               ),
        //               onTap: () {
        //                 // _signInWithFacebook();
        //               },
        //             ),
        //             SizedBox(
        //               width: 40,
        //             ),
        //             InkWell(
        //               child: Image.asset(
        //                 "assets/images/google.png",
        //                 height: 40,
        //               ),
        //               onTap: () {},
        //             )
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ]))),
    );
  }

  // Future<void> _signInWithFacebook() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     // Login to Facebook
  //     final LoginResult result = await FacebookAuth.instance.login();

  //     // Get access token
  //     final accessToken = result.accessToken!.token;

  //     // Authenticate with Firebase using Facebook access token
  //     final AuthCredential credential =
  //         FacebookAuthProvider.credential(accessToken);

  //     final UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //     _user = userCredential.user;

  //     // Store user data in Firestore
  //     await _firestore.collection('user').doc(_user!.uid).set({
  //       'full name': _user!.displayName,
  //       'email': _user!.email,
  //       'photoUrl': _user!.photoURL,
  //       'id': _user!.uid
  //       // Add other user data as needed
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     // Handle Firebase Auth exceptions
  //     print('FirebaseAuthException: $e');
  //   } catch (e) {
  //     // Handle other exceptions
  //     print('Error: $e');
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
}
