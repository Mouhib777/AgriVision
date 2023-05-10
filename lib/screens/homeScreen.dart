import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/screens/service/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get_time_ago/get_time_ago.dart';

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
                            color: Color.fromARGB(15, 158, 158, 158),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Got anything on your mind?...",
                              style: GoogleFonts.raleway(
                                letterSpacing: 2,
                                wordSpacing: 1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          print("object");
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        "What's new!",
                        style: GoogleFonts.montserratAlternates(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
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
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35))),
                                  color: Colors.white70,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Column(
                                            children: [
                                              Text(posts[index].name),
                                              Text(posts[index].date),
                                            ],
                                          ),
                                          // subtitle: Text(posts[index].date),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(posts[index]
                                                  .likes
                                                  .toString()),
                                              IconButton(
                                                icon: Icon(Icons.thumb_up),
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
                                          // fit: BoxFit.contain,
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
