import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/screens/chatScreen.dart';
import 'package:agri_vision/screens/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class chatScreenHome extends StatefulWidget {
  const chatScreenHome({super.key});

  @override
  State<chatScreenHome> createState() => _chatScreenHomeState();
}

class _chatScreenHomeState extends State<chatScreenHome> {
  @override
  void initState() {
    getUser_Data();
    super.initState();
  }

  var user_data;

  Future<DocumentSnapshot> getUser_Data() async {
    final User? user1 = FirebaseAuth.instance.currentUser;
    String? _uid = user1!.uid;
    var result1 =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      user_data = result1;
    });
    return result1;
  }

  @override
  Widget build(BuildContext context) {
    final User? userr = FirebaseAuth.instance.currentUser;
    final _uid = userr!.uid;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: Text(
            'Chat',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
        body: user_data?['premium'] ?? "" == "true"
            ? Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(_uid)
                          .collection('messages')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.docs.length == 0) {
                            return Center(
                              child: Text(
                                'No Chats Yet',
                                style: GoogleFonts.montserrat(fontSize: 16),
                              ),
                            );
                          }
                          return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: 5),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              var U_id = snapshot.data.docs[index].id;
                              var lastMsg =
                                  snapshot.data.docs[index]['last_msg'];
                              return FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(U_id)
                                      .get(),
                                  builder:
                                      (context, AsyncSnapshot asyncSnapshot) {
                                    var user2 = asyncSnapshot.data;
                                    if (asyncSnapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 80,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      48, 158, 158, 158)),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            user2['image'])),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      user2['full name'],
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${lastMsg}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              pushNewScreenWithRouteSettings(
                                                  context,
                                                  screen: chatScreen(
                                                      id: U_id,
                                                      name: user2["full name"]),
                                                  settings: RouteSettings(),
                                                  withNavBar: false);
                                            },
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
                            child: CircularProgressIndicator(
                          color: Colors.green,
                        ));
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 30),
                                  Container(
                                    // color:
                                    // Color.fromARGB(68, 198, 198, 198),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09),
                                        Text(
                                          "You are now on Basic user plan, To enjoy using Agrivision features to its fullest, contact us if you need any help",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                            "assets/images/Rectangle.png"),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              pushNewScreenWithRouteSettings(
                                                  context,
                                                  screen: paymentScreen(),
                                                  settings: RouteSettings(),
                                                  withNavBar: false,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino);
                                            },
                                            child: Text(
                                              "Upgrade to premium 2DT",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35.0)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ])))
                  ])));
  }
}
