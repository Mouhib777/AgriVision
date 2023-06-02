import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class editPassword extends StatefulWidget {
  const editPassword({super.key});

  @override
  State<editPassword> createState() => _editPasswordState();
}

class _editPasswordState extends State<editPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Edit password",
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Enter your new password, make sure it’s easy for you to remember and secure enough to use",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
