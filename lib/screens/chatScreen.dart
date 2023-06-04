import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class chatScreenHome extends StatefulWidget {
  const chatScreenHome({super.key});

  @override
  State<chatScreenHome> createState() => _chatScreenHomeState();
}

class _chatScreenHomeState extends State<chatScreenHome> {
  @override
  Widget build(BuildContext context) {
    final User? userr = FirebaseAuth.instance.currentUser;
    final _uid = userr!.uid;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('utilisateur')
                .doc(_uid)
                .collection('messages')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length < 1) {
                  return Center(
                    child: Text(
                      'No Chats Yet',
                      style: GoogleFonts.montserrat(fontSize: 16),
                    ),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 5),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var U_id = snapshot.data.docs[index].id;
                    var lastMsg = snapshot.data.docs[index]['last_msg'];
                    return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('utilisateur')
                            .doc(U_id)
                            .get(),
                        builder: (context, AsyncSnapshot asyncSnapshot) {
                          var client = asyncSnapshot.data;
                          if (asyncSnapshot.hasData) {
                            return ListTile(
                              title: Text(
                                client['Name'],
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Container(
                                child: Text(
                                  "${lastMsg}",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => chatScreen(
                                //               id: client["id"],
                                //               name: client["Name"],
                                //               number: client["Number"],

                                //               //  c_pic: transporter['image']
                                //             )));
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            );
                          }
                        });
                  },
                );
              }
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.green,
              ));
            },
          ),
        ),
      ],
    ));
  }
}
