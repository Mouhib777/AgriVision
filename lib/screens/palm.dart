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
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Palm',
          style: GoogleFonts.montserratAlternates(
              letterSpacing: 2, fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                // height: MediaQuery.of(context).size.height * 0.5,
                // width: MediaQuery.of(context).size.width,
                child: Image.file(widget.image!)),
            SizedBox(
              height: 10,
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
                      'hot/dry',
                      style: GoogleFonts.montserrat(
                          fontSize: 12, color: Colors.grey),
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
                      "100L/week",
                      style: GoogleFonts.montserrat(
                          fontSize: 12, color: Colors.grey),
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
                    // Image.asset(
                    //   "assets/images/icons/sunny-day.png",
                    //   height: 15,
                    // ),
                    Text(
                      "~1000 y",
                      style: GoogleFonts.montserrat(
                          fontSize: 12, color: Colors.grey),
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
                      "23m",
                      style: GoogleFonts.montserrat(
                          fontSize: 12, color: Colors.grey),
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
                style: GoogleFonts.montserrat(letterSpacing: 1),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
