import 'package:agri_vision/screens/loginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class profileSCreen extends StatefulWidget {
  const profileSCreen({super.key});

  @override
  State<profileSCreen> createState() => _profileSCreenState();
}

class _profileSCreenState extends State<profileSCreen> {
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
      body: Center(
        child: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
                color: Color.fromARGB(68, 198, 198, 198)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: user_data["image"] != null
                      ? NetworkImage(user_data["imageUrl"])
                          as ImageProvider<Object>?
                      : AssetImage("assets/images/splash.png"),
                )
              ],
            ),
          ))
        ])),
      ),
    );
  }
}
