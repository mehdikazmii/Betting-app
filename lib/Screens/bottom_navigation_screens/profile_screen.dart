import 'package:betting_app/Screens/bottom_navigation_screens/profile_sub_screens/saved_bet_screen.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/provider/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../entity/app_user.dart';
import '../../widgets/custom_round_button.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.user, required this.userProvider});
  static String id = 'profile';
  AppUser? user;
  UserProvider? userProvider;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.user!.profilePhotoPath);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int i = 0;
    return Scaffold(
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
                              widget.user!.profilePhotoPath == null
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 40,
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              widget.user!.profilePhotoPath!),
                                      backgroundColor: Colors.grey,
                                      radius: 40,
                                    ),
                              Text(
                                widget.user != null
                                    ? widget.user!.username!
                                    : 'username',
                                style: TextStyle(color: white, fontSize: 15),
                              ),
                              const Text(
                                'Bio',
                                style: TextStyle(
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
                                      'Level 23',
                                      style:
                                          TextStyle(color: white, fontSize: 15),
                                    ),
                                    Text(
                                      '-',
                                      style: TextStyle(
                                          color: yellow,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '20',
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
                                          '350',
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Edit Profile',
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => changeScreen(
                                          context, SavedBetScreen()),
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
                              function: () {},
                              text: 'Active Bets',
                            ),
                            CRoundButton(
                              active: true,
                              function: () {},
                              text: 'History',
                            )
                          ],
                        ),
                        Container(
                          height: height / 2.32,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: 20,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        decoration: BoxDecoration(
                                            color: blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                            // tileColor: blue,
                                            subtitle: Text(
                                              'Barca - Madrid',
                                              style: TextStyle(color: white),
                                            ),
                                            trailing: Text(
                                              "10000",
                                              style: TextStyle(
                                                  color: white, fontSize: 15),
                                            ),
                                            title: Text(
                                              "Why will win the party",
                                              style: TextStyle(color: white),
                                            )),
                                      );
                                    }),
                              ),
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
