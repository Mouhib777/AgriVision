import 'package:agri_vision/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class isMeOrNot extends StatelessWidget {
  final String message;
  final bool isMe;
  final Timestamp timee;
  isMeOrNot({required this.message, required this.isMe, required this.timee});

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = timee;
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(4),
              constraints: BoxConstraints(maxWidth: 250),
              decoration: BoxDecoration(
                color: isMe
                    ? Color(0xFFE4E4E4)
                    // Color.fromARGB(255, 102, 165, 180)
                    : primaryColor,
                // Color.fromARGB(255, 152, 101, 161),

                borderRadius: isMe
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(75),
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(55),
                      )
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(55),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(55),
                        topLeft: Radius.circular(30),
                      ),
              ),
              child: Text(message,
                  style: isMe
                      ? GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500))
                      : GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Color(0xFFE4E4E4),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )),
            ),
            Text(
              "${formattedTime}",
              style: GoogleFonts.montserrat(
                color: Colors.grey,
                fontSize: 10,
              ),
            )
          ],
        )
      ],
    );
  }
}
