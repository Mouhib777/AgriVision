import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/screens/posting.dart';
import 'package:agri_vision/screens/service/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get_time_ago/get_time_ago.dart' as timeago;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Post {
  final String name;
  final String date;
  final String writing;
  final String pictureUrl;
  final String id;
  int likes;

  Post(
      {required this.name,
      required this.date,
      required this.pictureUrl,
      required this.writing,
      required this.id,
      this.likes = 0});
}

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

  posts _posts = posts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Text(
                "Happy to see you again\n${user_data["full name"]}!",
                style: GoogleFonts.montserrat(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      InkWell(
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.grey, width: 0.3)),
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Text(
                              "Got anything on your mind?...",
                              style: GoogleFonts.raleway(
                                color: Colors.grey,
                                letterSpacing: 2,
                                wordSpacing: 1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          pushNewScreenWithRouteSettings(context,
                              screen: postingScreen(),
                              settings: RouteSettings(),
                              withNavBar: false);

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => postingScreen(),
                          //     ));
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        "What's new!",
                        style: GoogleFonts.montserratAlternates(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            List<Post> posts = snapshot.data!.docs.map((doc) {
                              return Post(
                                name: doc['name'],
                                date: doc['date'],
                                pictureUrl: doc['imageUrl'],
                                writing: doc['writing'],
                                likes: doc['likes'] ?? 0,
                                id: doc.id,
                              );
                            }).toList();
                            return ListView.builder(
                              itemCount: posts.length,
                              itemBuilder: (BuildContext context, int index) {
                                String dateTimeString = posts[index].date;
                                String dateTimeWithoutSeconds =
                                    dateTimeString.substring(0, 16);
                                print(dateTimeWithoutSeconds);
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35))),
                                  color: Color.fromARGB(255, 250, 247, 247),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Row(
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                child: Image.asset(
                                                    "assets/images/google.png"),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    posts[index].name,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  Text(
                                                    dateTimeWithoutSeconds,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.network(
                                          posts[index].pictureUrl,
                                          height: 320,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          posts[index].writing,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                  Icons.star_border_rounded),
                                              onPressed: () {
                                                // Increment the like count and update the Firestore document
                                                FirebaseFirestore.instance
                                                    .collection('posts')
                                                    .doc(snapshot
                                                        .data!.docs[index].id)
                                                    .update({
                                                  'likes':
                                                      FieldValue.increment(1),
                                                });
                                              },
                                            ),
                                            Text(posts[index].likes.toString()),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(Icons.comment_outlined),
                                            SizedBox(
                                              width: 190,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
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
