import 'package:agri_vision/screens/treeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class historyScreen extends StatefulWidget {
  const historyScreen({super.key});

  @override
  State<historyScreen> createState() => _historyScreenState();
}

class _historyScreenState extends State<historyScreen> {
  @override
  Widget build(BuildContext context) {
    User? _userr = FirebaseAuth.instance.currentUser;
    var _uid = _userr!.uid;
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    pushNewScreenWithRouteSettings(context,
                                        screen: treeScreen(),
                                        settings: RouteSettings(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade);
                                  },
                                  child: Text(
                                    "My trees",
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
                                CupertinoIcons.list_dash,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "history",
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
                              Icon(CupertinoIcons.time),
                            ],
                          ),
                          Expanded(
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(_uid)
                                      .collection('historique')
                                      .orderBy('date', descending: true)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: Image.asset(
                                              "assets/images/jungle-searching.png"));
                                    }
                                    if (snapshot.data!.docs.length == 0) {
                                      return Center(
                                          child: Column(
                                        children: [
                                          Image.asset(
                                              "assets/images/jungle-searching.png"),
                                          Text(
                                            "no detected trees yet",
                                            style: GoogleFonts
                                                .montserratAlternates(),
                                          )
                                        ],
                                      ));
                                    }
                                    final histo = snapshot.data!.docs;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: histo.length,
                                      itemBuilder: (context, index) {
                                        final histoo = histo[index];
                                        // final name = histoo['name'];
                                        // final image = histoo['imageUrl'];
                                        final date = histoo['date'];
                                        String dateTimeString = date;
                                        String dateTimeWithoutSeconds =
                                            dateTimeString.substring(0, 16);
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            width: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            // color: Colors.white,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 190,
                                                    height: 140,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              45),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            histoo['imageUrl']),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1, right: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // SizedBox(height: 5),
                                                        Text(
                                                          histoo['treetype'],
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          histoo['description'],
                                                          maxLines: 4,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/icons/snowflake.png",
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                  histoo[
                                                                      'weather'],
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          8,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/icons/drop.png",
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                  histoo[
                                                                      'water'],
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          8,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .time,
                                                                  size: 15,
                                                                ),
                                                                // Image.asset(
                                                                //   "assets/images/icons/sunny-day.png",
                                                                //   height: 15,
                                                                // ),
                                                                Text(
                                                                  histoo['age'],
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          8,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/icons/ruler.png",
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                  histoo[
                                                                      'size'],
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          8,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                        SizedBox(height: 10),
                                                        Text(
                                                          dateTimeWithoutSeconds,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 8,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }))
                        ]))),
          ),
        ])));
  }
}
