import 'package:agri_vision/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
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
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Happy to see you again\n${user_data["full name"]}!",
                  style: GoogleFonts.montserrat(
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 26),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("data"),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
