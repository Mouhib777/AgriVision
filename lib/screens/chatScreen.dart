import 'dart:convert';

import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/service/isMe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
  void initState() {
    getUser_Data();
    getUser_Data1();
    super.initState();
  }

  var user_data;

  Future<DocumentSnapshot> getUser_Data() async {
    final User? user1 = FirebaseAuth.instance.currentUser;
    String? _uid = user1!.uid;
    var result1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .get();
    setState(() {
      user_data = result1;
    });
    return result1;
  }

  var user_data1;

  Future<DocumentSnapshot> getUser_Data1() async {
    final User? user1 = FirebaseAuth.instance.currentUser;
    String? _uid = user1!.uid;
    var result1 =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      user_data1 = result1;
    });
    return result1;
  }

  @override
  Widget build(BuildContext context) {
    final String token = user_data?['deviceToken'];
    final String name1 = user_data1?['full name'];

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
                        Timestamp time = snapshot.data.docs[index]['date'];

                        return isMeOrNot(
                          message: snapshot.data.docs[index]['message'],
                          isMe: isMe,
                          timee: time,
                        );
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
                    // var token = user_data['deviceToken'];
                    print(widget.id);
                    print(_uid);
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
                      var data = {
                        'to': token.toString(),
                        'priority': 'high',
                        'notification': {
                          'title': "${name1}",
                          'body': '${message}'
                        },
                      };
                      await http.post(
                          Uri.parse('https://fcm.googleapis.com/fcm/send'),
                          body: jsonEncode(data),
                          headers: {
                            'Content-Type': 'application/json; charset=UTF-8',
                            'Authorization':
                                'key=AAAAtGg7I0s:APA91bGqrseufhz8PS22m3woF2acnCTNnp5B2Br-X1NO8sS_VYWeyuoXRE8hGI2B03nHkR36bJWWqTyyU477z1GhtZgkeUXCQNGPZR-d-tOeaHIZpkzi6IFvV0uvhhUJDsP9_Ms6M_EE'
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
