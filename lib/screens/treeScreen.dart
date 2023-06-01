import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/screens/history.dart';
import 'package:agri_vision/screens/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  var user_data;
  final User? _userr = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getUser_Data();
    super.initState();
  }

  Future<DocumentSnapshot> getUser_Data() async {
    var result1 = await FirebaseFirestore.instance
        .collection("users")
        .doc(_userr!.uid)
        .get();
    setState(() {
      user_data = result1;
    });
    return result1;
  }

  @override
  Widget build(BuildContext context) {
    final User? _userr = FirebaseAuth.instance.currentUser;
    final _uid = _userr!.uid;
    return Scaffold(
        backgroundColor: Colors.white,
        body: user_data?["premium"] ?? '' == 'true'
            ? SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
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
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              foregroundColor:
                                                  Colors.transparent,
                                            )),
                                        Icon(CupertinoIcons.list_dash),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              pushNewScreenWithRouteSettings(
                                                  context,
                                                  screen: historyScreen(),
                                                  settings: RouteSettings(),
                                                  withNavBar: true,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .fade);
                                            },
                                            child: Text(
                                              "history",
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              foregroundColor:
                                                  Colors.transparent,
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
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return AlertDialog(
                                                      shape:
                                                          ContinuousRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          45)),
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [],
                                                      ),
                                                      content: Column(
                                                        children: [
                                                          DropdownButton<
                                                              String>(
                                                            iconSize: 40,
                                                            value:
                                                                dropdownValue,
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                dropdownValue =
                                                                    newValue!;
                                                              });
                                                            },
                                                            items: <String>[
                                                              "Palm",
                                                              "Lemon",
                                                              "Olive",
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                  value,
                                                                  style: GoogleFonts.raleway(
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
                                                            decoration:
                                                                InputDecoration(
                                                              hintStyle: GoogleFonts
                                                                  .montserrat(),
                                                              labelStyle:
                                                                  GoogleFonts
                                                                      .montserrat(),
                                                              counterStyle:
                                                                  GoogleFonts
                                                                      .montserrat(),
                                                              hintText:
                                                                  'Number of trees',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              labelText:
                                                                  '  Number of trees',
                                                            ),
                                                            autofocus: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                          ),
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        Center(
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.5,
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      Timestamp
                                                                          timestamp =
                                                                          Timestamp
                                                                              .now();
                                                                      String
                                                                          dateString =
                                                                          timestamp
                                                                              .toDate()
                                                                              .toString();
                                                                      final User?
                                                                          _userr =
                                                                          FirebaseAuth
                                                                              .instance
                                                                              .currentUser;
                                                                      final _uid =
                                                                          _userr!
                                                                              .uid;
                                                                      if (dropdownValue ==
                                                                          'Palm') {
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('users')
                                                                            .doc(_uid)
                                                                            .collection('my trees')
                                                                            .doc()
                                                                            .set({
                                                                          "tree type":
                                                                              dropdownValue,
                                                                          "number":
                                                                              number,
                                                                          "description":
                                                                              "Date Palm is a symbol of the oasis culture in Tunisia. It's a tall, elegant tree with long, feather-like leaves that provide shade and beauty. ",
                                                                          "last time":
                                                                              dateString
                                                                        });
                                                                      } else if (dropdownValue ==
                                                                          'Lemon') {
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('users')
                                                                            .doc(_uid)
                                                                            .collection('my trees')
                                                                            .doc()
                                                                            .set({
                                                                          "description":
                                                                              "Lemon Tree is a small, evergreen tree with glossy leaves and fragrant white flowers. The fruit of the Lemon Tree is prized for its sour,",
                                                                          "tree type":
                                                                              dropdownValue,
                                                                          "last time":
                                                                              dateString,
                                                                          "number":
                                                                              number,
                                                                        });
                                                                      } else if (dropdownValue ==
                                                                          'Olive') {
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('users')
                                                                            .doc(_uid)
                                                                            .collection('my trees')
                                                                            .doc()
                                                                            .set({
                                                                          "description":
                                                                              " The Olive Tree is an iconic symbol of the Mediterranean region and is one of the oldest cultivated trees in the world. ",
                                                                          "tree type":
                                                                              dropdownValue,
                                                                          "last time":
                                                                              dateString,
                                                                          "number":
                                                                              number
                                                                        });
                                                                      }

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'add tree',
                                                                      style: GoogleFonts.montserrat(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          primaryColor,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(35.0)),
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
                                                    BorderRadius.circular(
                                                        35.0)),
                                          )),
                                    ),
                                  ]))),
                    ),
                    Container(
                      color: Color.fromARGB(68, 198, 198, 198),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(_uid)
                                .collection('my trees')
                                // .orderBy('date', descending: true)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.data!.docs.length == 0) {
                                return Center(
                                    child: Column(
                                  children: [
                                    Image.asset(
                                        "assets/images/jungle-searching.png"),
                                    Text(
                                      "no detected trees yet",
                                      style: GoogleFonts.montserratAlternates(),
                                    )
                                  ],
                                ));
                              }
                              final tree = snapshot.data!.docs;
                              return ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height: 10,
                                ),
                                shrinkWrap: true,
                                itemCount: tree.length,
                                itemBuilder: (context, index) {
                                  final trees = tree[index];
                                  final date = trees['last time'];
                                  String dateTimeString = date;
                                  String dateTimeWithoutSeconds =
                                      dateTimeString.substring(0, 16);
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                      ),
                                      // color: Colors.white,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 190,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(45),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/facebook.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 0),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1, right: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // SizedBox(height: 5),
                                                  Text(
                                                    trees['tree type'],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  Text(
                                                    trees['description'],
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "number :${trees['number']}",
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Last watering time $dateTimeWithoutSeconds",
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 8,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )
                                                  // SizedBox(height: 10),
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
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ]))
            : SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                foregroundColor:
                                                    Colors.transparent,
                                              )),
                                          Icon(CupertinoIcons.list_dash),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                pushNewScreenWithRouteSettings(
                                                    context,
                                                    screen: historyScreen(),
                                                    settings: RouteSettings(),
                                                    withNavBar: true,
                                                    pageTransitionAnimation:
                                                        PageTransitionAnimation
                                                            .fade);
                                              },
                                              child: Text(
                                                "history",
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                foregroundColor:
                                                    Colors.transparent,
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
                                              "Feature not available for\nBasic plan users",
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
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                    ]))))
                  ])));
  }
}
