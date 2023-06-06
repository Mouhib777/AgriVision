import 'package:agri_vision/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          "Manage users",
          style:
              GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "No users founded",
                  style: GoogleFonts.montserrat(),
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 5),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var U_id = snapshot.data.docs[index].id;
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(U_id)
                        .get(),
                    builder: (context, AsyncSnapshot asyncSnapshot) {
                      var user2 = asyncSnapshot.data;
                      if (asyncSnapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFF4F4F6)),
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              title: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          NetworkImage(user2['image'])),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        user2['full name'],
                                        style: GoogleFonts.montserrat(
                                            color: Color(0xFF121826),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // onTap: () {
                              //   // pushNewScreenWithRouteSettings(
                              //   //     context,
                              //   //     screen: chatScreen(
                              //   //         id: U_id,
                              //   //         name: user2["full name"]),
                              //   //     settings: RouteSettings(),
                              //   //     withNavBar: false);
                              // },
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  user2["isAdmin"] == "true"
                                      ? InkWell(
                                          onTap: () async {
                                            user2["management"] == "enabled"
                                                ? await FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(U_id)
                                                    .update({
                                                    "management": "disabled"
                                                  })
                                                : await FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(U_id)
                                                    .update({
                                                    "management": "enabled"
                                                  });
                                          },
                                          child: Text(
                                            user2["management"],
                                            style: GoogleFonts.montserrat(
                                                color: user2["management"] ==
                                                        "disabled"
                                                    ? Colors.red
                                                    : primaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        )
                                      : Text("")
                                ],
                              ),
                            ),
                          ),
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
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
}
