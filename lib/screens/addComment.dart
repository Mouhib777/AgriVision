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
            // SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 20,
            //     ),
            //     Text(widget.name),
            //   ],
            // ),
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
            ),
            widget.image == ''
                ? Text("")
                : Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.writing,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff201F21)),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
