import 'package:agri_vision/screens/treeScreen.dart';
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
                                            PageTransitionAnimation.sizeUp);
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
                          )
                        ]))),
          )
        ])));
  }
}
