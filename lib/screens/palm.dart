import 'package:agri_vision/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class palmScreen extends StatefulWidget {
  const palmScreen({super.key});

  @override
  State<palmScreen> createState() => _palmScreenState();
}

class _palmScreenState extends State<palmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Palm',
          style: GoogleFonts.montserratAlternates(
              letterSpacing: 2, fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
    );
  }
}
