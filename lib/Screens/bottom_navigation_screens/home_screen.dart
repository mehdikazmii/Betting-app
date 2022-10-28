// ignore_for_file: avoid_print

import 'package:betting_app/Screens/bottom_navigation_screens/place_bet_screen.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helpers/screen_navigation.dart';
import '../../helpers/utils.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';
import 'report_screens/report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool liked = false;
  bool shared = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  List<String> likes = [];
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

  getLikes() {
    try {
      var snapshots = instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('likedBets')
          .snapshots();
      snapshots.forEach((element) {
        for (var element in element.docs) {
          likes.add(element.id);
        }
      });
    } catch (e) {
      print('Get likes error');
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
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
                  return card(context, data);
                },
              );
            }));
  }

  Padding card(BuildContext context, QueryDocumentSnapshot data) {
    DateTime dateTime = DateTime.parse(data['dateTime'].toDate().toString());
    print(saves);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.3,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 35),
                        child: CustomText(
                          text: data['def'],
                          size: 20,
                        ),
                      ),
                      IconButton(
                          onPressed: () =>
                              changeScreen(context, const ReportScreen()),
                          icon: CircleAvatar(
                              radius: 20,
                              backgroundColor: white,
                              child: Center(
                                  child: Icon(
                                Icons.warning_rounded,
                                color: black,
                              ))))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CRoundButton(
                          function: () {}, text: data['option1'], active: true),
                      const CustomText(
                        text: 'X 2.0',
                        size: 20,
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CRoundButton(
                          function: () {}, text: data['option2'], active: true),
                      const CustomText(
                        text: 'X 2.0',
                        size: 20,
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: 'Ends',
                          weight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            text:
                                "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                          ),
                          CustomText(
                            text: '${dateTime.hour}:${dateTime.minute}',
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: blue,
                              child: Icon(
                                Icons.person,
                                color: white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CRoundButton(
                              function: () {},
                              text: data['name'],
                              active: true,
                              fontSize: 12,
                              height: 40,
                              width: 90,
                            )
                          ],
                        ),
                      ),
                      CRoundButton(
                        function: () {
                          changeScreen(context, PLaceBetScreen(data: data));
                        },
                        text: 'Place Bet',
                        textColor: black,
                        color: yellow,
                        fontSize: 17,
                        width: 120,
                        height: 50,
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: data['comment'],
                          size: 16,
                          color: black,
                        ),
                        Row(
                          children: [
                            CustomText(
                              text: '44',
                              size: 16,
                              color: black,
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.insert_comment_rounded,
                              color: black,
                              size: 18,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            text: '12',
                            color: blue,
                            size: 25,
                            weight: FontWeight.bold,
                          ),
                          const CustomText(
                            text: 'Sub',
                            weight: FontWeight.bold,
                            size: 18,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            const CustomText(text: '0'),
                            IconButton(
                                splashRadius: 5.0,
                                onPressed: () {
                                  setState(() {
                                    liked ? liked = false : liked = true;
                                  });
                                  onLike(data);
                                },
                                icon: liked
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red)
                                    : Icon(
                                        Icons.favorite_border,
                                        color: white,
                                      ))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            const CustomText(text: '0'),
                            IconButton(
                              splashRadius: 5.0,
                              onPressed: () {
                                setState(() {
                                  shared ? shared = false : shared = true;
                                });
                              },
                              icon: Icon(
                                Icons.loop,
                                color: shared ? blue : white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: IconButton(
                            splashRadius: 5.0,
                            icon: Icon(
                              Icons.collections_bookmark_outlined,
                              color: saves.isNotEmpty
                                  ? saves.contains(data.id)
                                      ? blue
                                      : Colors.white
                                  : null,
                            ),
                            onPressed: () {
                              saves.contains(data.id)
                                  ? onRemove(data.id)
                                  : onSave(data);
                            },
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onSave(data) {
    print(data.id);
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('savedBets')
          .doc(data.id)
          .set({}).then((value) {
        setState(() {
          saves.add(data.id);
        });
        showSnackBar('The bet has been saved', context);
      });
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  onRemove(id) {
    print(id);
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('savedBets')
          .doc(id)
          .delete()
          .then((value) {
        setState(() {
          saves.remove(id);
        });

        showSnackBar('The bet has been removed', context);
      });
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  onLike(data) {
    print(data.id);
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('likedBets')
          .doc(data.id)
          .set({});
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }
}
