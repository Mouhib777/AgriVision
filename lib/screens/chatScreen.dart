import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/service/isMe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class chatScreen extends StatefulWidget {
  final String id;
  final String name;

  const chatScreen({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  @override
  Widget build(BuildContext context) {
    final User? userr = FirebaseAuth.instance.currentUser;
    final _uid = userr!.uid;
    TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          widget.name,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_uid)
                    .collection('messages')
                    .doc(widget.id)
                    .collection('chats')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/AgriVision.png"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Start conversation with ${widget.name}",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        bool isMe =
                            snapshot.data.docs[index]['sender_id'] == _uid;
                        return isMeOrNot(
                            message: snapshot.data.docs[index]['message'],
                            isMe: isMe);
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
              color: Colors.transparent,
              padding: EdgeInsetsDirectional.all(8),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    style: GoogleFonts.montserrat(textStyle: TextStyle()),
                    controller: _controller,
                    //   cursorColor: Color(0xFFE4E4E4),
                    decoration: InputDecoration(
                        labelText: 'Type Your Message...',
                        labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 15,
                        )),

                        //fontWeight: FontWeight.bold

                        fillColor: Color(0xFFE4E4E4),
                        filled: true,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFFE4E4E4),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none)
                        // border: OutlineInputBorder(

                        //   borderRadius: BorderRadius.circular(15),
                        // )
                        ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    String message = _controller.text;
                    String? T_id;
                    _controller.clear();
                    if (message.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.id)
                          .collection('messages')
                          .doc(_uid)
                          .collection('chats')
                          .add({
                        "sender_id": _uid,
                        "receiver_id": widget.id,
                        "message": message,
                        "date": DateTime.now(),
                        "type": "text",
                      }).then((value) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.id)
                            .collection('messages')
                            .doc(_uid)
                            .set({'last_msg': message, 'date': DateTime.now()});
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(_uid)
                          .collection('messages')
                          .doc(widget.id)
                          .collection('chats')
                          .add({
                        "sender_id": _uid,
                        "receiver_id": widget.id,
                        "message": message,
                        "date": DateTime.now(),
                        "type": "text",
                      }).then((value) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(_uid)
                            .collection('messages')
                            .doc(widget.id)
                            .set({'last_msg': message, 'date': DateTime.now()});
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }
}
