import 'package:agri_vision/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class addComment extends StatefulWidget {
  final String name;
  final String? date;
  final int? likes;
  final String image;
  final String writing;
  final String docId;
  final String id;
  const addComment(
      {super.key,
      required this.name,
      required this.date,
      required this.likes,
      required this.image,
      required this.writing,
      required this.docId,
      required this.id});

  @override
  State<addComment> createState() => _addCommentState();
}

class _addCommentState extends State<addComment> {
  String? _comment;
  var _commentt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String dateTimeString = "${widget.date}";
    String dateTimeWithoutSeconds = dateTimeString.substring(0, 16);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: GoogleFonts.montserrat(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.bubble_left_bubble_right_fill))
        ],
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.image == ''
                ? Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      widget.writing,
                      style: GoogleFonts.montserrat(),
                    ),
                  )
                : Image.network(widget.image),
            Text(
              dateTimeWithoutSeconds,
              style: GoogleFonts.montserratAlternates(),
            ),
            widget.image == ''
                ? Text("")
                : Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.writing,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff201F21)),
                    ),
                  ),
            Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(
                    "assets/images/icons/star.png",
                    height: 25,
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.docId)
                        .update({
                      'likes': FieldValue.increment(1),
                    });
                    EasyLoading.showToast("liked");
                  },
                ),

                Text(
                  '${widget.likes}',
                  style: GoogleFonts.montserratAlternates(),
                ),
                // ;
                // }
                // )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _commentt,
                      onChanged: (value) {
                        _comment = value;
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Your comment...',
                        hintStyle: GoogleFonts.raleway(
                          letterSpacing: 4,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        String _controller = _commentt.text;
                        Timestamp timestamp = Timestamp.now();
                        String dateString = timestamp.toDate().toString();
                        if (_controller.isNotEmpty) {
                          _commentt.clear();
                          await FirebaseFirestore.instance
                              .collection('posts')
                              .doc(widget.docId)
                              .collection('comments')
                              .doc()
                              .set({
                            "name": widget.name,
                            "comment": _comment,
                            "date": dateString
                          });
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          EasyLoading.showSuccess(
                              "your comment has been shared");
                        } else {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          EasyLoading.showError(
                              "empty comment can't be shared");
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: primaryColor,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.docId)
                  .collection("comments")
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Image.asset("assets/images/jungle-searching.png"));
                }
                if (snapshot.data!.docs.length == 0) {
                  return Center(
                      child: Column(
                    children: [
                      Image.asset("assets/images/jungle-searching.png"),
                      Text(
                        "no comments yet",
                        style: GoogleFonts.montserratAlternates(),
                      )
                    ],
                  ));
                }

                final comments = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    final name = comment['name'];
                    final text = comment['comment'];
                    final date = comment['date'];
                    String dateTimeString = date;
                    String dateTimeWithoutSeconds =
                        dateTimeString.substring(0, 16);
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 215, 250, 216),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            text,
                            style: GoogleFonts.montserrat(),
                          ),
                          subtitle: Row(
                            children: [
                              Text(name),
                              SizedBox(
                                width: 10,
                              ),
                              Text(dateTimeWithoutSeconds)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      )),
    );
  }
}
