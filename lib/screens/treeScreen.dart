import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/screens/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class treeScreen extends StatefulWidget {
  const treeScreen({super.key});

  @override
  State<treeScreen> createState() => _treeScreenState();
}

class _treeScreenState extends State<treeScreen> {
  String dropdownValue = 'Palm';
  String? number;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'My Trees',
              style: GoogleFonts.montserrat(
                letterSpacing: 0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 26,
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                    color: Color.fromARGB(68, 198, 198, 198)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "My trees",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    foregroundColor: Colors.transparent,
                                  )),
                              Icon(CupertinoIcons.list_dash),
                              SizedBox(
                                width: 100,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    pushNewScreenWithRouteSettings(context,
                                        screen: historyScreen(),
                                        settings: RouteSettings(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade);
                                  },
                                  child: Text(
                                    "history",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    foregroundColor: Colors.transparent,
                                  )),
                              Icon(
                                CupertinoIcons.time,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                            shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(45)),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [],
                                            ),
                                            content: Column(
                                              children: [
                                                DropdownButton<String>(
                                                  iconSize: 40,
                                                  value: dropdownValue,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      dropdownValue = newValue!;
                                                    });
                                                  },
                                                  items: <String>[
                                                    "Palm",
                                                    "Lemon",
                                                    "Olive",
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style:
                                                            GoogleFonts.raleway(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextFormField(
                                                  onChanged: (value) {
                                                    number = value;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintStyle: GoogleFonts
                                                        .montserrat(),
                                                    labelStyle: GoogleFonts
                                                        .montserrat(),
                                                    counterStyle: GoogleFonts
                                                        .montserrat(),
                                                    hintText: 'Number of trees',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    labelText:
                                                        '  Number of trees',
                                                  ),
                                                  autofocus: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              Center(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: ElevatedButton(
                                                      onPressed: () async {
                                                        final User? _userr =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;
                                                        final _uid =
                                                            _userr!.uid;
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(_uid)
                                                            .collection(
                                                                'my trees')
                                                            .doc()
                                                            .set({
                                                          "tree type":
                                                              dropdownValue,
                                                          "number": number
                                                        });

                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'add tree',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            primaryColor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        35.0)),
                                                      )),
                                                ),
                                              ),
                                            ]);
                                      });
                                    },
                                  );
                                },
                                child: Text(
                                  'Add trees',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(35.0)),
                                )),
                          )
                        ]))),
          )
        ])));
  }
}
