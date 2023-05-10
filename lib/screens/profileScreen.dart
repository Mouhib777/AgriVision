import 'package:agri_vision/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class profileSCreen extends StatefulWidget {
  const profileSCreen({super.key});

  @override
  State<profileSCreen> createState() => _profileSCreenState();
}

class _profileSCreenState extends State<profileSCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Text("sign out"),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: Duration.zero,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    loginScreen()));
          },
        ),
      ),
    );
  }
}
