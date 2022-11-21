// ignore_for_file: avoid_print

import 'package:badges/badges.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/bet_search_card.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_button.dart';
import 'package:betting_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_round_button.dart';

class UserCardScreen extends StatefulWidget {
  const UserCardScreen({super.key, required this.userData});
  final Map<dynamic, dynamic> userData;

  @override
  State<UserCardScreen> createState() => _UserCardScreenState();
}

class _UserCardScreenState extends State<UserCardScreen> {
  double coins = 0.0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  int selected = 0;
  List<String> followers = [];
  List<String> requests = [];

  @override
  void initState() {
    getfollowers();
    getRequests();
    super.initState();
  }

  getfollowers() {
    try {
      var snapshots = instance
          .collection('users')
          .doc(widget.userData['id'])
          .collection('followers')
          .snapshots();
      snapshots.forEach((snapshot) {
        for (var element in snapshot.docs) {
          if (!mounted) return;
          setState(() {
            followers.add(element.id);
          });
        }
      });
      print(followers);
    } catch (e) {
      print(e);
    }
  }

  getRequests() {
    try {
      var snapshots = instance
          .collection('users')
          .doc(widget.userData['id'])
          .collection('request')
          .snapshots();
      snapshots.forEach((snapshot) {
        for (var element in snapshot.docs) {
          if (!mounted) return;
          setState(() {
            requests.add(element.id);
          });
        }
      });
      print(requests);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(followers);
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          actions: [Container()],
          shadowColor: black,
          backgroundColor: black,
          title: Text(
            'User',
            style: TextStyle(color: white),
          ),
        ),
        body: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                color: black,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: width,
                        height: height / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: width / 3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget.userData['verified']
                                      ? Badge(
                                          badgeColor: Colors.blue,
                                          toAnimate: false,
                                          padding: const EdgeInsets.all(4),
                                          position: BadgePosition.topEnd(
                                              top: 0, end: 0),
                                          badgeContent: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.verified,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    widget.userData[
                                                        'profile_photo_path']),
                                            backgroundColor: Colors.grey,
                                            radius: 40,
                                          ),
                                        )
                                      : Badge(
                                          badgeColor: Colors.grey,
                                          toAnimate: false,
                                          padding: const EdgeInsets.all(4),
                                          position: BadgePosition.topEnd(
                                              top: 0, end: 0),
                                          badgeContent: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.verified,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    widget.userData[
                                                        'profile_photo_path']),
                                            backgroundColor: Colors.grey,
                                            radius: 40,
                                          ),
                                        ),
                                  Text(
                                    widget.userData['name'],
                                    style:
                                        TextStyle(color: white, fontSize: 15),
                                  ),
                                  Text(
                                    widget.userData['bio'] ?? 'Bio',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.emoji_events_outlined,
                                          color: yellow,
                                        ),
                                        Text(
                                          widget.userData['level'].toString(),
                                          style: TextStyle(
                                              color: white, fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 70,
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                widget.userData['wallet']
                                                    .toString(),
                                                style: TextStyle(color: white),
                                              ),
                                              Image(
                                                color: yellow,
                                                image: const AssetImage(
                                                    'assets/black-coin.png'),
                                                height: 20,
                                                width: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                  color: white, fontSize: 15),
                                            ),
                                            Text(
                                              'Following',
                                              style: TextStyle(
                                                  color: white, fontSize: 15),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                  color: white, fontSize: 15),
                                            ),
                                            Text(
                                              'Followers',
                                              style: TextStyle(
                                                  color: white, fontSize: 15),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    !widget.userData['private']
                                        ? followers.isNotEmpty
                                            ? !followers.contains(
                                                    auth.currentUser!.uid)
                                                ? CustomButton(
                                                    height: 40,
                                                    buttonName: 'Follow',
                                                    function: () {
                                                      follow();
                                                    })
                                                : CustomButton(
                                                    height: 40,
                                                    buttonName: 'Remove',
                                                    color: Colors.grey,
                                                    function: () {
                                                      remove();
                                                    })
                                            : CustomButton(
                                                height: 40,
                                                buttonName: 'Follow',
                                                function: () {
                                                  follow();
                                                })
                                        : requests.isNotEmpty ||
                                                followers.isNotEmpty
                                            ? !requests.contains(
                                                    auth.currentUser!.uid)
                                                ? !followers.contains(
                                                        auth.currentUser!.uid)
                                                    ? CustomButton(
                                                        height: 40,
                                                        buttonName: 'Request',
                                                        function: () {
                                                          request();
                                                        })
                                                    : CustomButton(
                                                        height: 40,
                                                        color: Colors.grey,
                                                        buttonName: 'Followed',
                                                        function: () {})
                                                : CustomButton(
                                                    height: 40,
                                                    buttonName: 'Cancel',
                                                    color: Colors.grey,
                                                    function: () {
                                                      cancel();
                                                    })
                                            : CustomButton(
                                                height: 40,
                                                buttonName: 'Request',
                                                function: () {
                                                  request();
                                                })
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      !widget.userData['private'] ||
                              followers.contains(auth.currentUser!.uid)
                          ? SizedBox(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CRoundButton(
                                        active: true,
                                        function: () {
                                          selected == 0
                                              ? null
                                              : setState(() {
                                                  selected = 0;
                                                });
                                        },
                                        text: 'Active Bets',
                                      ),
                                      CRoundButton(
                                        active: true,
                                        function: () {
                                          selected == 1
                                              ? null
                                              : setState(() {
                                                  selected = 1;
                                                });
                                        },
                                        text: 'History',
                                      )
                                    ],
                                  ),
                                  selected == 0
                                      ? Container(
                                          height: height / 1.95,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: StreamBuilder<
                                                          QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('publish')
                                                          .orderBy(
                                                              'publishTime',
                                                              descending: true)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return Container();
                                                        }
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Container();
                                                        }
                                                        var item =
                                                            snapshot.data!.docs;

                                                        return ListView.builder(
                                                          itemCount: snapshot
                                                              .data!
                                                              .docs
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            var data =
                                                                item[index];
                                                            DateTime dateTime =
                                                                DateTime.parse(data[
                                                                        'dateTime']
                                                                    .toDate()
                                                                    .toString());
                                                            return data['uid'] ==
                                                                    widget.userData[
                                                                        'id']
                                                                ? Container(
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    decoration: BoxDecoration(
                                                                        color: dateTime.isAfter(DateTime.now())
                                                                            ? blue
                                                                            : Colors
                                                                                .green,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    child: ListTile(
                                                                        onTap: (() => changeScreen(
                                                                            context,
                                                                            BetSearchCard(
                                                                              data: data,
                                                                              dateTime: dateTime,
                                                                              user: null,
                                                                            ))),
                                                                        subtitle: Text(
                                                                          "${data['option1']} - ${data['option2']}",
                                                                          style:
                                                                              TextStyle(color: white),
                                                                        ),
                                                                        trailing: Text(
                                                                          data['totalBet'] == ''
                                                                              ? '0'
                                                                              : data['totalBet'],
                                                                          style: TextStyle(
                                                                              color: white,
                                                                              fontSize: 15),
                                                                        ),
                                                                        title: Text(
                                                                          data[
                                                                              'def'],
                                                                          style:
                                                                              TextStyle(color: white),
                                                                        )),
                                                                  )
                                                                : Container();
                                                          },
                                                        );
                                                      })),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: height / 1.95,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: StreamBuilder<
                                                          QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(widget
                                                              .userData['id'])
                                                          .collection('history')
                                                          .orderBy(
                                                              'publishTime',
                                                              descending: true)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return Container();
                                                        }
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Container();
                                                        }
                                                        var item =
                                                            snapshot.data!.docs;

                                                        return ListView.builder(
                                                          itemCount: snapshot
                                                              .data!
                                                              .docs
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            var data =
                                                                item[index];
                                                            DateTime dateTime =
                                                                DateTime.parse(data[
                                                                        'dateTime']
                                                                    .toDate()
                                                                    .toString());
                                                            return data['uid'] ==
                                                                    widget.userData[
                                                                        'id']
                                                                ? Container(
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            blue,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    child: ListTile(
                                                                        subtitle: Text(
                                                                          "${data['option1']} - ${data['option2']}",
                                                                          style:
                                                                              TextStyle(color: white),
                                                                        ),
                                                                        trailing: Text(
                                                                          data['totalBet'] == ''
                                                                              ? '0'
                                                                              : data['totalBet'],
                                                                          style: TextStyle(
                                                                              color: white,
                                                                              fontSize: 15),
                                                                        ),
                                                                        title: Text(
                                                                          data[
                                                                              'def'],
                                                                          style:
                                                                              TextStyle(color: white),
                                                                        )),
                                                                  )
                                                                : Container();
                                                          },
                                                        );
                                                      })),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Divider(
                                    color: white,
                                    height: 2,
                                  ),
                                  const SizedBox(
                                    height: 200,
                                  ),
                                  const Center(
                                    child: CustomText(
                                      text: 'Private',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ))));
  }

  follow() {
    try {
      instance
          .collection('users')
          .doc(widget.userData['id'])
          .collection('followers')
          .doc(auth.currentUser!.uid)
          .set({}).then((value) {
        instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('followings')
            .doc(widget.userData['id'])
            .set({}).then((value) {
          showSnackBar('followed', context);
          setState(() {});
        });
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }

  request() {
    try {
      instance
          .collection('users')
          .doc(widget.userData['id'])
          .collection('request')
          .doc(auth.currentUser!.uid)
          .set({}).then((value) {
        showSnackBar('Requested', context);
        setState(() {});
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }

  cancel() {
    try {
      instance
          .collection('users')
          .doc(widget.userData['id'])
          .collection('request')
          .doc(auth.currentUser!.uid)
          .delete()
          .then((value) {
        showSnackBar('cancel request', context);
        setState(() {
          requests.remove(auth.currentUser!.uid);
        });
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }

  remove() {
    try {
      instance
          .collection('users')
          .doc(widget.userData['id'])
          .collection('followers')
          .doc(auth.currentUser!.uid)
          .delete()
          .then((value) {
        showSnackBar('Follower has been removed', context);
        setState(() {
          followers.remove(auth.currentUser!.uid);
        });
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }
}
