import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen(
      {super.key,
      required this.comment,
      required this.name,
      required this.betId,
      required this.currentUserName});
  final String comment;
  final String name;
  final String betId;
  final String currentUserName;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController comemntController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: black,
        backgroundColor: black,
        title: const Text('Comments'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: black,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommentTile(name: widget.name, comment: widget.comment),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('publish')
                        .doc(widget.betId)
                        .collection('comments')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      var item = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = item[index];
                          return CommentTile(
                              name: data['name'], comment: data['comment']);
                        },
                      );
                    }),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: const BoxDecoration(
                          color: Color(0xFFE1E4E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          controller: comemntController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Add comment',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.4))),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          comemntController.text.isNotEmpty
                              ? addComment(comemntController.text.trim())
                              : null;
                        },
                        icon: Icon(
                          Icons.send_rounded,
                          color: white,
                          size: 25,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  addComment(comment) {
    try {
      instance
          .collection('publish')
          .doc(widget.betId)
          .collection('comments')
          .doc()
          .set({
        'name': widget.currentUserName,
        'comment': comment,
        'time': DateTime.now()
      }).then((value) {
        comemntController.clear();
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }
}

class CommentTile extends StatelessWidget {
  const CommentTile({
    Key? key,
    required this.name,
    required this.comment,
  }) : super(key: key);

  final String name;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      // decoration: BoxDecoration(
      //     border: Border.all(color: white),
      //     borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          '@ $name',
        ),
        textColor: white,
        subtitle: Container(
            margin: const EdgeInsets.only(left: 15), child: Text(comment)),
      ),
    );
  }
}
