import 'dart:io';

import 'package:agri_vision/constant/constant.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class palmScreen extends StatefulWidget {
  final File? image;
  const palmScreen({super.key, required this.image});

  @override
  State<palmScreen> createState() => _palmScreenState();
}

class _palmScreenState extends State<palmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70),
                topRight: Radius.circular(70),
              ),
              color: Colors.grey,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/palm.jpg"),
              ),
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.237,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/icons/snowflake.png",
                                    height: 30,
                                  ),
                                  Text(
                                    'warm/sunny',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/icons/drop.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "50L/week",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                children: [
                                  Icon(
                                    CupertinoIcons.time,
                                    size: 30,
                                  ),
                                  Text(
                                    "50 y",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/icons/ruler.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "15m",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "The Arecaceae is a family of perennial flowering plants in the monocot order Arecales. Their growth form can be climbers, shrubs, tree-like and stemless plants, all commonly known as palms. Those having a tree-like form are called palm trees.[3] Currently, 181 genera with around 2,600 species are known,[4][5] most of which are restricted to tropical and subtropical climates. Most palms are distinguished by their large, compound, evergreen leaves, known as fronds, arranged at the top of an unbranched stem. However, palms exhibit an enormous diversity in physical characteristics and inhabit nearly every type of habitat within their range, from rainforests to deserts." +
                                  "Palms are among the best known and most extensively cultivated plant families. They have been important to humans throughout much of history. Many common products and foods are derived from palms. In contemporary times, palms are also widely used in landscaping. In many historical cultures, because of their importance as food, palms were symbols for such ideas as victory, peace, and fertility. ",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.montserrat(
                                  letterSpacing: 1, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
