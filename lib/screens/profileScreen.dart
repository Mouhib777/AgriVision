import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/screens/additional/contactUs.dart';
import 'package:agri_vision/screens/additional/editProfile.dart';
import 'package:agri_vision/screens/additional/password.dart';
import 'package:agri_vision/screens/additional/postScreen.dart';
import 'package:agri_vision/screens/additional/termsScreen.dart';
import 'package:agri_vision/screens/additional/userPlan.dart';
import 'package:agri_vision/screens/loginScreen.dart';
import 'package:agri_vision/screens/posting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var url =
      "https://firebasestorage.googleapis.com/v0/b/agrivision-d140c.appspot.com/o/posts%2F06sr49ki1x.jpg?alt=media&token=865c53aa-bd15-4f58-a09d-85a5a0e5bc06";
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  var userData;

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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                    color: Color.fromARGB(68, 198, 198, 198),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text(
                        userData?["full name"] ?? "",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        userData?["plan"] ?? "",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: primaryColor,
                        ),
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
                              color: Color(0XFF6C727F),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                pushNewScreenWithRouteSettings(context,
                                    screen: editProfile(),
                                    settings: RouteSettings(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino);
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.person_crop_circle,
                                        color: Color(0xFFD3D5DA),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'General Info',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Color(0xff121826)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Manage Account infos',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color(0xFF6C727F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            CupertinoIcons.chevron_forward),
                                        color: Color(0xFFD3D5DA),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                pushNewScreenWithRouteSettings(context,
                                    screen: editPassword(),
                                    settings: RouteSettings(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino);
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.lock_fill,
                                        color: Color(0xFFD3D5DA),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Password',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Color(0xff121826)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Manage Password',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color(0xFF6C727F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            CupertinoIcons.chevron_forward),
                                        color: Color(0xFFD3D5DA),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                pushNewScreenWithRouteSettings(context,
                                    screen: userPlan(),
                                    settings: RouteSettings(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino);
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.flag_fill,
                                        color: Color(0xFFD3D5DA),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'User Plan',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Color(0xff121826)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'What plan are you on',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color(0xFF6C727F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            CupertinoIcons.chevron_forward),
                                        color: Color(0xFFD3D5DA),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                pushNewScreenWithRouteSettings(context,
                                    screen: postScreen(),
                                    settings: RouteSettings(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino);
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.tree,
                                        color: Color(0xFFD3D5DA),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Posts',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Color(0xff121826)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Your posting history',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color(0xFF6C727F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            CupertinoIcons.chevron_forward),
                                        color: Color(0xFFD3D5DA),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                                  "Others",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0XFF6C727F),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                pushNewScreenWithRouteSettings(context,
                                    screen: contactUs(),
                                    settings: RouteSettings(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino);
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.phone_fill,
                                        color: Color(0xFFD3D5DA),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Contact us',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Color(0xff121826)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Canaux de contact',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color(0xFF6C727F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            CupertinoIcons.chevron_forward),
                                        color: Color(0xFFD3D5DA),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                pushNewScreenWithRouteSettings(context,
                                    screen: termsScreen(),
                                    settings: RouteSettings(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino);
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.lock_shield_fill,
                                        color: Color(0xFFD3D5DA),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Terms and conditions',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Color(0xff121826)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'User Terms and policy',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color(0xFF6C727F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            CupertinoIcons.chevron_forward),
                                        color: Color(0xFFD3D5DA),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).push(PageRouteBuilder(
                                    transitionDuration: Duration.zero,
                                    pageBuilder:
                                        (context, animation, secondary) =>
                                            loginScreen()));
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 1),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Log out',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Colors.red),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Disconnect from account',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            CupertinoIcons.chevron_forward),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              left: 0,
              right: 0,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.green,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green,
                          width: 1,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(userData?["image"] ?? ""),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
