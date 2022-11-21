// ignore_for_file: avoid_print

import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Followings extends StatefulWidget {
  const Followings({super.key});

  @override
  State<Followings> createState() => _FollowingsState();
}

class _FollowingsState extends State<Followings> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  List<String> users = [];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  getUsers() {
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('followers')
          .get()
          .then((value) {
        for (var element in value.docs) {
          users.add(element.id);
        }
        setState(() {});
        print(users);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: black,
          backgroundColor: black,
          title: const Text('Followings'),
        ),
        body: SafeArea(
          child: Container(
            color: black,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  var item = snapshot.data!.docs;

                  return users.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = item[index];
                            print(users);
                            return users.contains(data.id)
                                ? ListTile(
                                    textColor: white,
                                    onTap: (() {}),
                                    trailing: GestureDetector(
                                      onTap: (() => remove(data.id)),
                                      child: const CustomText(
                                        text: 'Remove',
                                        size: 15,
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              data['profile_photo_path']),
                                    ),
                                    title: Text(
                                      data['name'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      (data['bio'] == null || data['bio'] == "")
                                          ? "No bio"
                                          : data['bio'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : Container();
                          },
                        )
                      : Container();
                }),
          ),
        ));
  }

  remove(id) {
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('followings')
          .doc(id)
          .delete()
          .then((value) {
        instance
            .collection('users')
            .doc(id)
            .collection('followers')
            .doc(auth.currentUser!.uid)
            .delete()
            .then((value) {
          showSnackBar('removed', context);
          setState(() {
            users.remove(id);
          });
        });
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }
}
