import 'package:agri_vision/constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    String? email;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Row(
            children: [
              SizedBox(
                width: 40,
              ),
              Text(
                "Reset Password",
                style: GoogleFonts.montserratAlternates(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 40,
              ),
              Text(
                "Recover your account by resetting your\npassword",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 40,
              ),
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
            ],
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 350,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                resetPassword(email.toString());
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                Navigator.pop(context);
                EasyLoading.showInfo("Check your email to reset your password");
              },
              child: Text(
                "Reset your password",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resetPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      // Display a success message or navigate to a success screen
    } catch (e) {
      // Handle the error based on the Firebase Auth error codes
      print('Password reset failed: $e');
      // Display an error message to the user
    }
  }
}
