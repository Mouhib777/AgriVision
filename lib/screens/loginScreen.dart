import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/navBar/navBar.dart';
import 'package:agri_vision/screens/homeScreen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
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
          height: 30,
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
        FadeInUpBig(
          child: SizedBox(
              child: Column(children: [
            SizedBox(
              width: 350,
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
              width: 350,
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

                maxLength: 40,
                //   onChanged: (value) {
                //     email = value;
                //   },
                // ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 350,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => navBar(),
                      ));
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
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
                  onTap: () {},
                )
              ],
            ),
          ])),
        ),
        SizedBox(
          height: 30,
        ),
        FadeIn(
          delay: Duration(milliseconds: 1500),
          child: SizedBox(
            child: Column(
              children: [
                Text(
                  'Or continue with',
                  style: GoogleFonts.montserrat(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Image.asset(
                        "assets/images/facebook.png",
                        height: 40,
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      child: Image.asset(
                        "assets/images/google.png",
                        height: 40,
                      ),
                      onTap: () {},
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]))),
    );
  }
}
