import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          "Manage users",
          style:
              GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      // body: strea,
    );
  }
}
