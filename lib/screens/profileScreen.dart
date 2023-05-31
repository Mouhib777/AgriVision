import 'package:agri_vision/constant/constant.dart';
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
  var url =
      "https://firebasestorage.googleapis.com/v0/b/agrivision-d140c.appspot.com/o/posts%2F06sr49ki1x.jpg?alt=media&token=865c53aa-bd15-4f58-a09d-85a5a0e5bc06";
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
      body: Stack(
        children: [
          Column(
            children: [
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
                    color: Color.fromARGB(68, 198, 198, 198),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 130,
                        ),
                        Text(
                          user_data?["full name"] ?? "",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          user_data?["plan"] ?? "",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: primaryColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "General",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0XFF6C727F)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              left: 0,
              right: 0,
              child: CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage(user_data?["image"] ?? ""))),
        ],
      ),
    );
  }
}
