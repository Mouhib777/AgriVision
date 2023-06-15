import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/screens/addComment.dart';
import 'package:agri_vision/screens/posting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Post {
  final String name;
  final String date;
  final String writing;
  final String pictureUrl;
  final String id;
  int likes;
  final String userid;
  final CollectionReference<Map<String, dynamic>> likesCollectionRef;

  Post({
    required this.name,
    required this.date,
    required this.pictureUrl,
    required this.writing,
    required this.id,
    required this.userid,
    this.likes = 0,
  }) : likesCollectionRef = FirebaseFirestore.instance
            .collection('posts')
            .doc(id)
            .collection('likes');

  Future<void> toggleLike(String userId) async {
    final DocumentReference<Map<String, dynamic>> userLikeRef =
        likesCollectionRef.doc(userId);
    final DocumentSnapshot<Map<String, dynamic>> userLikeSnapshot =
        await userLikeRef.get();

    if (userLikeSnapshot.exists) {
      await userLikeRef.delete();
      likes--;
    } else {
      await userLikeRef.set({});
      likes++;
    }
  }
}

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool isLiked = false;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  var userData;

  Future<DocumentSnapshot> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user!.uid;
    final DocumentSnapshot result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userData = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Happy to see you again\n${userData?['full name'] ?? ''}!",
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
                            border: Border.all(color: Colors.grey, width: 0.3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Text(
                              "Got anything on your mind?...",
                              style: GoogleFonts.raleway(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: postingScreen(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .orderBy('date', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('No Posts Found'),
                            );
                          }

                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                final post = Post(
                                  id: snapshot.data!.docs[index].id,
                                  name: snapshot.data!.docs[index]['name'],
                                  date: snapshot.data!.docs[index]['date'],
                                  writing: snapshot.data!.docs[index]
                                      ['writing'],
                                  pictureUrl: snapshot.data!.docs[index]
                                      ['pictureUrl'],
                                  userid: snapshot.data!.docs[index]['userid'],
                                  likes: snapshot.data!.docs[index]['likes'],
                                );

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      snapshot.data!.docs[index]
                                                          ['pictureUrl'],
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['name'],
                                                        style:
                                                            GoogleFonts.raleway(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['date'],
                                                        style:
                                                            GoogleFonts.raleway(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  final User? user =
                                                      FirebaseAuth
                                                          .instance.currentUser;
                                                  final String? uid = user!.uid;

                                                  await post.toggleLike(uid!);
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  post.likesCollectionRef
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .get()
                                                      .then(
                                                    (DocumentSnapshot
                                                        documentSnapshot) {
                                                      if (documentSnapshot
                                                          .exists) {
                                                        isLiked = true;
                                                      } else {
                                                        isLiked = false;
                                                      }
                                                    },
                                                  ) as IconData?,
                                                  color: isLiked
                                                      ? Colors.red
                                                      : null,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                ['writing'],
                                            style: GoogleFonts.raleway(),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            height: 200,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  snapshot.data!.docs[index]
                                                      ['pictureUrl'],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      pushNewScreen(
                                                        context,
                                                        screen: addComment(),
                                                        withNavBar: false,
                                                        pageTransitionAnimation:
                                                            PageTransitionAnimation
                                                                .cupertino,
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.message_outlined,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "12 comments",
                                                    style: GoogleFonts.raleway(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.share,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
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

void main() {
  runApp(MaterialApp(
    home: homeScreen(),
  ));
}
