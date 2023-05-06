import 'dart:async';

import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/screens/loginScreen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    Timer(
        Duration(
          seconds: 3,
        ), () async {
      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   if (user == null) {
      Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (context, animation, secondaryAnimation) =>
              loginScreen()));

      //   } else {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => mainScreen(),
      //         ));
      //   }
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FadeIn(
            delay: Duration(milliseconds: 2500),
            child: Image.asset(
              "assets/images/splash.png",
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Empower your tree care\nwith the tap of an app',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 3),
          )
        ]),
      ),
    );
  }
}
