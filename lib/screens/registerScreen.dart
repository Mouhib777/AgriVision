import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/navBar/navBar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  bool _acceptedTerms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  FadeInLeft(
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
                  FadeInLeft(
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
                    delay: Duration(seconds: 1),
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
                delay: Duration(seconds: 1),
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
                  FadeInLeft(
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
              SizedBox(
                width: 330,
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.montserrat(),
                    labelStyle: GoogleFonts.montserrat(),
                    counterStyle: GoogleFonts.montserrat(),
                    hintText: 'Full name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: '  Full name',
                    // counterText:
                    //     '*Please use a verified e-mail',
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  // maxLength: 40,
                  //   onChanged: (value) {
                  //     email = value;
                  //   },
                  // ),
                ),
              ),
              SizedBox(
                height: 20,
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
                  // maxLength: 40,
                  //   onChanged: (value) {
                  //     email = value;
                  //   },
                  // ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 330,
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.montserrat(),
                    labelStyle: GoogleFonts.montserrat(),
                    counterStyle: GoogleFonts.montserrat(),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: '  Password',
                  ),
                  autofocus: false,

                  // maxLength: 40,
                  //   onChanged: (value) {
                  //     email = value;
                  //   },
                  // ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 330,
                child: TextField(
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

                  // maxLength: 40,
                  //   onChanged: (value) {
                  //     email = value;
                  //   },
                  // ),
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
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 350,
                height: 55,
                child: ElevatedButton(
                  onPressed: _acceptedTerms
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => navBar(),
                              ));
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
                height: 20,
              ),
              Row(
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
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              )
            ]))));
  }
}
