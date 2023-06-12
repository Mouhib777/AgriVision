import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/constant.dart';

class editPassword extends StatefulWidget {
  const editPassword({super.key});

  @override
  State<editPassword> createState() => _editPasswordState();
}

class _editPasswordState extends State<editPassword> {
  String? password;
  bool _obscureText = false;
  var _passwordController = TextEditingController();
  var _confirmController = TextEditingController();
  bool _isLoading = false;
  String? p_confirm;
  var userData;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<DocumentSnapshot> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String? uid = user!.uid;
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userData = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Edit password",
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Enter your new password, make sure it’s easy for you to remember and secure enough to use",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 16),
              ),
              SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.montserrat(),
                  labelStyle: GoogleFonts.montserrat(),
                  counterStyle: GoogleFonts.montserrat(),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: '  Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                autofocus: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  } else {
                    setState(() {
                      password = value;
                    });
                    return null;
                  }
                },
                onChanged: (value) {
                  password = value;
                },
                obscureText: _obscureText,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _confirmController,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.montserrat(),
                  labelStyle: GoogleFonts.montserrat(),
                  counterStyle: GoogleFonts.montserrat(),
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: '  Confirm Password',
                ),
                autofocus: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'password not confirmed';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  } else {
                    setState(() {
                      p_confirm = value;
                    });
                    return null;
                  }
                },
                onChanged: (value) {
                  p_confirm = value;
                },
                obscureText: true,
              ),
              Text(
                "Passwords must be at least 8 characters long (only alphabet letter, number and .!?*)",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF7F7F7F)),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 333,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    var currentPassword = userData?['password'] ?? "";
                    var emaaail = userData?['email'] ?? "";

                    final _user = FirebaseAuth.instance.currentUser;
                    final _uid = _user!.uid;
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emaaail, password: currentPassword);
                    if (password != null && password == p_confirm) {
                      setState(() {
                        _isLoading = true;
                      });
                      if (FirebaseAuth.instance.currentUser != null) {
                        try {
                          await FirebaseAuth.instance.currentUser!
                              .updatePassword(password!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Password changed!'),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                          print(e);
                        }
                      }
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(_uid)
                          .update({"password": password.toString()});
                      setState(() {
                        _isLoading = false;
                      });
                    } else if (password != p_confirm) {
                      EasyLoading.showError('Please confirm your password');
                    } else {
                      EasyLoading.showError('Nothing to update');
                    }
                  },
                  child: Text(
                    "Update password",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
