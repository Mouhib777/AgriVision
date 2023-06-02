import 'package:agri_vision/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class contactUs extends StatefulWidget {
  const contactUs({super.key});

  @override
  State<contactUs> createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Contact us",
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Color.fromRGBO(0, 0, 0, 1)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "You can contact us through one of these chanels",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(
                  height: 150,
                ),
                Container(
                  height: 50,
                  width: 333,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: Text(
                    "contactus@agrivision.com",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 333,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: Text(
                    "+216 55 555 555",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 333,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: Text(
                    "Facebook.com/agrivision.tn",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  )),
                ),
                SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: 333,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {},
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
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
          ),
        ),
      ),
    );
  }
}
