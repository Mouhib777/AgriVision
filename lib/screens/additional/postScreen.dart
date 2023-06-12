import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class postScreen extends StatefulWidget {
  const postScreen({super.key});

  @override
  State<postScreen> createState() => _postScreenState();
}

final user = FirebaseAuth.instance.currentUser;
final _uid = user!.uid;

class _postScreenState extends State<postScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            "My posts",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(_uid)
              .collection('historique')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            List<DocumentSnapshot> document = snapshot.data!.docs;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              itemCount: document.length,
              itemBuilder: (BuildContext context, int index) {
                String title = document[index]['treetype'];
                String imageUrl = document[index]['imageUrl'];

                return GestureDetector(
                  onTap: () {
                    print('Tapped on item at index $index');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          '${title} tree',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
