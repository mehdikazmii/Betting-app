import 'package:betting_app/Screens/bottom_navigation_screens/profile_screens/edit_profile_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/profile_screens/followers.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/profile_screens/followings.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/profile_screens/saved_bet_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/bet_search_card.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/search_screen.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/provider/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import '../../../entity/app_user.dart';
import '../../../widgets/custom_round_button.dart';
import '../../../widgets/drawer.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.user, required this.userProvider});
  static String id = 'profile';
  AppUser? user;
  UserProvider? userProvider;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selected = 0;
  List<String> followers = [];
  List<String> followings = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  void initState() {
    getFollowers();
    getFollowings();
    super.initState();
  }

  getFollowers() {
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('followers')
          .get()
          .then((value) {
        for (var element in value.docs) {
          followers.add(element.id);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  getFollowings() {
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('followings')
          .get()
          .then((value) {
        for (var element in value.docs) {
          followings.add(element.id);
        }
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user!.profilePhotoPath);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawerr(
        user: widget.user,
      ),
      appBar: AppBar(
        title: const Center(
            child: Image(
          image: AssetImage('assets/pbets.jpg'),
          height: 25,
        )),
        shadowColor: Colors.black,
        backgroundColor: Colors.black,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                Icons.menu,
                color: yellow,
              ));
        }),
        actions: [
          Row(
            children: [
              Text(
                widget.user!.wallet.toString(),
                style: TextStyle(
                    color: white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image(
                    image: const AssetImage(
                      'assets/black-coin.png',
                    ),
                    color: yellow,
                    height: 20,
                    width: 20,
                  ))
            ],
          )
        ],
      ),
      backgroundColor: black,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              widget.user!.verified
                                  ? Badge(
                                      badgeColor: Colors.blue,
                                      toAnimate: false,
                                      padding: const EdgeInsets.all(4),
                                      position:
                                          BadgePosition.topEnd(top: 0, end: 0),
                                      badgeContent: const Padding(
                                        padding: EdgeInsets.only(bottom: 0),
                                        child: Icon(
                                          Icons.verified,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: widget.user!.profilePhotoPath ==
                                                  null ||
                                              widget.user!.profilePhotoPath!
                                                  .isEmpty
                                          ? const CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 40,
                                            )
                                          : CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      widget.user!
                                                          .profilePhotoPath!),
                                              backgroundColor: Colors.grey,
                                              radius: 40,
                                            ),
                                    )
                                  : widget.user!.profilePhotoPath != null ||
                                          widget.user!.profilePhotoPath!
                                              .isNotEmpty
                                      ? CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(widget
                                                  .user!.profilePhotoPath!),
                                          backgroundColor: Colors.grey,
                                          radius: 40,
                                        )
                                      : const CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 40,
                                        ),
                              Text(
                                widget.user != null
                                    ? widget.user!.username!
                                    : 'username',
                                style: TextStyle(color: white, fontSize: 15),
                              ),
                              Text(
                                widget.user!.bio == ''
                                    ? 'Bio'
                                    : widget.user!.bio,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      widget.user!.level.toString(),
                                      style:
                                          TextStyle(color: white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.user!.wallet.toString(),
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
                                    GestureDetector(
                                      onTap: (() => changeScreen(
                                          context, const Followings())),
                                      child: Column(
                                        children: [
                                          Text(
                                            followings.length.toString(),
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
                                    ),
                                    GestureDetector(
                                      onTap: (() => changeScreen(
                                          context, const FollowersScreen())),
                                      child: Column(
                                        children: [
                                          Text(
                                            followers.length.toString(),
                                            style: TextStyle(
                                                color: white, fontSize: 15),
                                          ),
                                          Text(
                                            'Followers',
                                            style: TextStyle(
                                                color: white, fontSize: 15),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () => changeScreen(
                                          context, const EditProfileScreen()),
                                      child: Container(
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(color: white),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => changeScreen(
                                          context,
                                          SavedBetScreen(
                                            user: widget.user,
                                          )),
                                      icon: Icon(
                                          Icons.collections_bookmark_rounded,
                                          color: white),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.send_outlined,
                                          color: white,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                height: height / 2.32,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('publish')
                                                .orderBy('publishTime',
                                                    descending: true)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container();
                                              }
                                              var item = snapshot.data!.docs;

                                              return ListView.builder(
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var data = item[index];
                                                  DateTime dateTime =
                                                      DateTime.parse(
                                                          data['dateTime']
                                                              .toDate()
                                                              .toString());
                                                  return data['uid'] ==
                                                          widget.user!.id
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4),
                                                          decoration: BoxDecoration(
                                                              color: dateTime.isAfter(
                                                                      DateTime
                                                                          .now())
                                                                  ? blue
                                                                  : Colors
                                                                      .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: ListTile(
                                                              onTap: () {
                                                                changeScreen(
                                                                    context,
                                                                    BetSearchCard(
                                                                        data:
                                                                            data,
                                                                        user: widget
                                                                            .user,
                                                                        dateTime:
                                                                            dateTime));
                                                              },
                                                              subtitle: Text(
                                                                "${data['option1']} - ${data['option2']}",
                                                                style: TextStyle(
                                                                    color:
                                                                        white),
                                                              ),
                                                              trailing: Text(
                                                                data['totalBet'] ==
                                                                        ''
                                                                    ? '0'
                                                                    : data[
                                                                        'totalBet'],
                                                                style: TextStyle(
                                                                    color:
                                                                        white,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              title: Text(
                                                                data['def'],
                                                                style: TextStyle(
                                                                    color:
                                                                        white),
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
                                height: height / 2.32,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(widget.user!.id)
                                                .collection('history')
                                                .orderBy('publishTime',
                                                    descending: true)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container();
                                              }
                                              var item = snapshot.data!.docs;

                                              return ListView.builder(
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var data = item[index];
                                                  // DateTime dateTime =
                                                  //     DateTime.parse(
                                                  //         data['dateTime']
                                                  //             .toDate()
                                                  //             .toString());
                                                  return data['uid'] ==
                                                          widget.user!.id
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4),
                                                          decoration: BoxDecoration(
                                                              color: blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: ListTile(
                                                              subtitle: Text(
                                                                "${data['option1']} - ${data['option2']}",
                                                                style: TextStyle(
                                                                    color:
                                                                        white),
                                                              ),
                                                              trailing: Text(
                                                                data['totalBet'] ==
                                                                        ''
                                                                    ? '0'
                                                                    : data[
                                                                        'totalBet'],
                                                                style: TextStyle(
                                                                    color:
                                                                        white,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              title: Text(
                                                                data['def'],
                                                                style: TextStyle(
                                                                    color:
                                                                        white),
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
                ],
              ))),
    );
  }
}
