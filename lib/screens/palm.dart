import 'dart:io';

import 'package:agri_vision/constant/constant.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:typewritertext/typewritertext.dart';

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
        title: FadeInDown(
          child: Text(
            'Palm',
            style: GoogleFonts.montserratAlternates(
                letterSpacing: 2, fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FadeInDownBig(
                child: SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.5,
                    // width: MediaQuery.of(context).size.width,
                    child: Image.file(widget.image!))),
            SizedBox(
              height: 10,
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
