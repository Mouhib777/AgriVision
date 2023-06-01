import 'package:cloud_firestore/cloud_firestore.dart';

class posts {
  getPosts() {
    return FirebaseFirestore.instance.collection('posts').doc().snapshots();
  }
}
