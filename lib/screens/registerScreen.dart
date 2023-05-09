import 'package:agri_vision/constant/constant.dart';
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
                height: 30,
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
              Row(
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
                  maxLength: 40,
                  //   onChanged: (value) {
                  //     email = value;
                  //   },
                  // ),
                ),
              ),
            ]))));
  }
}
