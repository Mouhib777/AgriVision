import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class addComment extends StatefulWidget {
  final String name;
  final String? date;
  final int? likes;
  final String image;
  final String writing;
  const addComment({
    super.key,
    required this.name,
    required this.date,
    required this.likes,
    required this.image,
    required this.writing,
  });

  @override
  State<addComment> createState() => _addCommentState();
}

class _addCommentState extends State<addComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: GoogleFonts.montserrat(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.image == ''
                ? Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      widget.writing,
                      style: GoogleFonts.montserrat(),
                    ),
                  )
                : Image.network(widget.image),
            Divider(
              thickness: 1,
            )
          ],
        ),
      )),
    );
  }
}
