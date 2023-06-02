import 'package:agri_vision/screens/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../constant/constant.dart';

class userPlan extends StatefulWidget {
  const userPlan({super.key});

  @override
  State<userPlan> createState() => _userPlanState();
}

class _userPlanState extends State<userPlan> {
  var userData;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<DocumentSnapshot> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String? uid = user!.uid;
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userData = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            "User plan",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color.fromRGBO(0, 0, 0, 1)),
          ),
          centerTitle: true,
        ),
        body: (userData?['plan'] ?? "") == "Premium plan"
            ? Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          "You are now on Premium user plan, enjoy using Agrivision features to its fullest, contact us if you need any help",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Image.asset("assets/images/Success.png"),
                        SizedBox(
                          width: 333,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back to profile",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
