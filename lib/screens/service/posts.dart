import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class posts {
  getPosts() {
    return FirebaseFirestore.instance.collection('posts').doc().snapshots();
  }
}
