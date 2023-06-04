import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class isMeOrNot extends StatelessWidget {
  final String message;
  final bool isMe;
  //final Timestamp time;
  isMeOrNot({
    required this.message,
    required this.isMe,
    //required this.time
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(4),
          constraints: BoxConstraints(maxWidth: 250),
          decoration: BoxDecoration(
            color: isMe
                ? Colors.red
                // Color.fromARGB(255, 102, 165, 180)
                : Colors.green,
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
                          color: Colors.amber,
                          fontSize: 14,
                          fontWeight: FontWeight.w500))
                  : GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )),
        )
      ],
    );
  }
}
