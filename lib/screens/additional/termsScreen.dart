import 'package:agri_vision/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class termsScreen extends StatefulWidget {
  const termsScreen({super.key});

  @override
  State<termsScreen> createState() => _termsScreenState();
}

class _termsScreenState extends State<termsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Terms and conditions",
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Color.fromRGBO(0, 0, 0, 1)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "#Terms and Conditions of Use ",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para1,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "## User Account",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para2,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "## Use of the App",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para3,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "## Permissions",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para4,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "## Privacy",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para5,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "## Intellectual Property",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para6,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "## Disclaimer of Warranties",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para7,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "## Limitation of Liability",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para8,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "## Changes to the Terms and Conditions",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para9,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "## Contact Us",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  para10,
                  style: GoogleFonts.montserrat(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
