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
      body: Center(
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
                para1,
                style: GoogleFonts.montserrat(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
