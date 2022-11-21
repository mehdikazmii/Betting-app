// ignore_for_file: avoid_print

import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/bet_search_card.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../entity/app_user.dart';

class SavedBetScreen extends StatefulWidget {
  const SavedBetScreen({super.key, required this.user});
  final AppUser? user;
  @override
  State<SavedBetScreen> createState() => _SavedBetScreenState();
}

class _SavedBetScreenState extends State<SavedBetScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  List<String> saves = [];
  @override
  void initState() {
    getSaves();
    super.initState();
  }

  getSaves() {
    try {
      var snapshots = instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('savedBets')
          .snapshots();
      snapshots.forEach((element) {
        for (var element in element.docs) {
          saves.add(element.id);
        }
      });
    } catch (e) {
      print('Get save beets error');
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          shadowColor: black,
          backgroundColor: black,
          title: Text(
            'Saved Bets',
            style: TextStyle(color: yellow),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('publish')
                .orderBy('publishTime', descending: true)
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
                  return saves.contains(data.id)
                      ? customSavedTile(context, data)
                      : Container();
                },
              );
            }));
  }

  GestureDetector customSavedTile(context, QueryDocumentSnapshot data) {
    DateTime dateTime = DateTime.parse(data['dateTime'].toDate().toString());
    return GestureDetector(
      onTap: () => changeScreen(context,
          BetSearchCard(data: data, user: widget.user, dateTime: dateTime)),
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
                color: blue, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      data['def'],
                      style: TextStyle(color: white, fontSize: 15),
                    ),
                    Text(
                      "${data['option1']} - ${data['option2']}",
                      style: TextStyle(color: white, fontSize: 15),
                    )
                  ],
                ),
                Text(
                  'Ends in ${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}',
                  style: TextStyle(color: white, fontSize: 15),
                )
              ],
            ),
          )),
    );
  }
}
