import 'package:agri_vision/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class treeScreen extends StatefulWidget {
  const treeScreen({super.key});

  @override
  State<treeScreen> createState() => _treeScreenState();
}

class _treeScreenState extends State<treeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'My Trees',
              style: GoogleFonts.montserrat(
                letterSpacing: 0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 26,
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                    color: Color.fromARGB(68, 198, 198, 198)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "My trees",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    foregroundColor: Colors.transparent,
                                  )),
                              Icon(CupertinoIcons.list_dash),
                              SizedBox(
                                width: 100,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "history",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    foregroundColor: Colors.transparent,
                                  )),
                              Icon(CupertinoIcons.time),
                            ],
                          )
                        ]))),
          )
        ])));
  }
}
