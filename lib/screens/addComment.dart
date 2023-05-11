import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String docId;
  const addComment(
      {super.key,
      required this.name,
      required this.date,
      required this.likes,
      required this.image,
      required this.writing,
      required this.docId});

  @override
  State<addComment> createState() => _addCommentState();
}

class _addCommentState extends State<addComment> {
  String? _comment;
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
            // Divider(
            //   thickness: 1,
            // ),
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
            Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(
                    "assets/images/icons/star.png",
                    height: 25,
                  ),
                  onPressed: () {
                    // Increment the like count and update the Firestore document
                    FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.docId)
                        .update({
                      'likes': FieldValue.increment(1),
                    });
                  },
                ),
                // SizedBox(
                //   width: 0,
                // ),
                Text('${widget.likes}')
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  onChanged: (value) {
                    _comment = value;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Your comment...',
                    hintStyle: GoogleFonts.raleway(
                      letterSpacing: 4,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
