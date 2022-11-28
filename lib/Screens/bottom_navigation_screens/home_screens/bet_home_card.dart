// ignore_for_file: avoid_print

import 'package:betting_app/Screens/bottom_navigation_screens/home_screens/comments_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/home_screens/place_bet_again_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/home_screens/place_bet_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/user_card_screen.dart';
import 'package:betting_app/widgets/custom_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../entity/app_user.dart';
import '../../../helpers/constant.dart';
import '../../../helpers/screen_navigation.dart';
import '../../../helpers/utils.dart';
import '../../../widgets/custom_round_button.dart';
import '../../../widgets/custom_text.dart';
import '../report_screens/report_screen.dart';

class BetHomeCard extends StatefulWidget {
  const BetHomeCard(
      {super.key,
      required this.data,
      required this.user,
      required this.dateTime});
  final QueryDocumentSnapshot<Object?> data;
  final AppUser? user;
  final DateTime dateTime;
  @override
  State<BetHomeCard> createState() => _BetHomeCardState();
}

class _BetHomeCardState extends State<BetHomeCard> {
  String selected = '';
  int index = 3;
  bool liked = false;
  bool shared = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  List<String> likes = [];
  List<String> saves = [];
  List<String> betPlaced = [];
  bool isLoading = false;
  @override
  void initState() {
    getSaves();
    getBets();
    getLikes();
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
          !saves.contains(element.id) ? saves.add(element.id) : null;
        }
      });
    } catch (e) {
      print('Get save beets error');
      print(e.toString());
    }
  }

  getBets() {
    try {
      var snapshots = instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('betPlaced')
          .snapshots();
      snapshots.forEach((element) {
        for (var element in element.docs) {
          betPlaced.add(element.id);
        }
      }).then((value) => print('got bets placed by users'));
    } catch (e) {
      print('Get bets error');
      print(e.toString());
    }
  }

  getLikes() {
    try {
      var snapshots = instance
          .collection('publish')
          .doc(widget.data.id)
          .collection('likedBets')
          .snapshots();
      snapshots.forEach((element) {
        for (var element in element.docs) {
          !likes.contains(element.id) ? likes.add(element.id) : null;
        }
      });
    } catch (e) {
      print('Get likes error');
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.3,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 35),
                          child: CustomText(
                            text: widget.data['def'],
                            size: 20,
                          ),
                        ),
                        IconButton(
                            onPressed: () => changeScreen(
                                context,
                                ReportScreen(
                                  data: widget.data,
                                  name: widget.user!.username,
                                )),
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
                          function: () {
                            showSnackBar(
                                '${widget.data['option1']} has been selected',
                                context);
                            selected = 'option1';
                            setState(() {
                              index = 0;
                            });
                            print(selected);
                          },
                          text: widget.data['option1'],
                          active: true,
                          color: index == 0 ? Colors.green : Colors.blue,
                        ),
                        CustomText(
                          text: "X ${widget.data['multiplier']}",
                          size: 20,
                          weight: FontWeight.bold,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CRoundButton(
                          function: () {
                            showSnackBar(
                                '${widget.data['option2']} has been selected',
                                context);
                            selected = 'option2';
                            setState(() {
                              index = 1;
                            });
                            print(selected);
                          },
                          text: widget.data['option2'],
                          active: true,
                          color: index == 1 ? Colors.green : Colors.blue,
                        ),
                        CustomText(
                          text: "X ${widget.data['multiplier']}",
                          size: 20,
                          weight: FontWeight.bold,
                        )
                      ],
                    ),
                    widget.data['option3'] != ''
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CRoundButton(
                                function: () {
                                  showSnackBar(
                                      '${widget.data['option3']} has been selected',
                                      context);
                                  selected = 'option3';
                                  setState(() {
                                    index = 2;
                                  });

                                  print(selected);
                                },
                                text: widget.data['option3'],
                                active: true,
                                color: index == 2 ? Colors.green : Colors.blue,
                              ),
                              CustomText(
                                text: "X ${widget.data['multiplier']}",
                                size: 20,
                                weight: FontWeight.bold,
                              )
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.dateTime.isAfter(DateTime.now())
                        ? Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomText(
                                    text:
                                        "${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}",
                                  ),
                                  CustomText(
                                    text:
                                        '${widget.dateTime.hour}:${widget.dateTime.minute}',
                                  )
                                ],
                              ),
                            ],
                          )
                        : const Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              text: 'Ended',
                              weight: FontWeight.bold,
                            ),
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
                                function: () {
                                  widget.data['uid'] != 'Admin'
                                      ? widget.data['uid'] != widget.user!.id
                                          ? userProfile(context)
                                          : null
                                      : showSnackBar(
                                          'Created by admin', context);
                                },
                                text: widget.data['name'],
                                active: true,
                                fontSize: 12,
                                height: 40,
                                width: 90,
                              )
                            ],
                          ),
                        ),
                        betPlaced.contains(widget.data.id)
                            ? CRoundButton(
                                function: () {
                                  changeScreen(
                                      context,
                                      PlaceBetAgainSCreen(
                                          data: widget.data,
                                          name: widget.user!.username!,
                                          user: widget.user!));
                                },
                                text: 'Bet Again',
                                color: Colors.grey,
                              )
                            : widget.dateTime.isAfter(DateTime.now())
                                ? CRoundButton(
                                    function: () {
                                      selected.isNotEmpty
                                          ? changeScreen(
                                              context,
                                              PLaceBetScreen(
                                                  data: widget.data,
                                                  selected: selected,
                                                  name: widget.user!.username!,
                                                  user: widget.user!))
                                          : showSnackBar(
                                              'Select any option to Place bet',
                                              context);
                                    },
                                    text: 'Place Bet',
                                    textColor: black,
                                    color: yellow,
                                    fontSize: 17,
                                    width: 120,
                                    height: 50,
                                  )
                                : CRoundButton(
                                    function: () {},
                                    text: 'Bet Ended',
                                    color: Colors.grey,
                                  )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => changeScreen(
                        context,
                        CommentsScreen(
                          name: widget.data['name'],
                          comment: widget.data['comment'],
                          betId: widget.data.id,
                          currentUserName: widget.user!.username!,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: widget.data['comment'],
                              size: 16,
                              color: black,
                            ),
                            Row(
                              children: [
                                // CustomText(
                                //   text: '',
                                //   size: 16,
                                //   color: black,
                                // ),
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     CustomText(
                        //       text: '12',
                        //       color: blue,
                        //       size: 25,
                        //       weight: FontWeight.bold,
                        //     ),
                        //     const CustomText(
                        //       text: 'Sub',
                        //       weight: FontWeight.bold,
                        //       size: 18,
                        //     )
                        //   ],
                        // ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              CustomText(text: likes.length.toString()),
                              IconButton(
                                  splashRadius: 5.0,
                                  onPressed: () {
                                    likes.contains(widget.user!.id)
                                        ? onRemoveLike()
                                        : onLike();
                                  },
                                  icon: likes.contains(widget.user!.id)
                                      ? const Icon(Icons.favorite,
                                          color: Colors.red)
                                      : Icon(
                                          Icons.favorite_border,
                                          color: white,
                                        ))
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 5),
                        //   child: Row(
                        //     children: [
                        //       const CustomText(text: '0'),
                        //       IconButton(
                        //         splashRadius: 5.0,
                        //         onPressed: () {
                        //           setState(() {
                        //             shared ? shared = false : shared = true;
                        //           });
                        //         },
                        //         icon: Icon(
                        //           Icons.loop,
                        //           color: shared ? blue : white,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: IconButton(
                              splashRadius: 5.0,
                              icon: Icon(Icons.collections_bookmark_outlined,
                                  color: !saves.contains(widget.data.id)
                                      ? white
                                      : blue),
                              onPressed: () {
                                saves.contains(widget.data.id)
                                    ? onRemove(widget.data.id)
                                    : onSave(widget.data);
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
      ),
    );
  }

  userProfile(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    instance.collection('users').doc(widget.data['uid']).get().then((value) {
      setState(() {
        isLoading = false;
      });
      changeScreen(context, UserCardScreen(userData: value.data()!));
    });
  }

  onSave(data) {
    setState(() {
      saves.add(widget.data.id);
    });
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('savedBets')
          .doc(widget.data.id)
          .set({}).then((value) {
        setState(() {});
        print('saved');
      });
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  onRemove(id) {
    setState(() {
      saves.remove(id);
    });
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('savedBets')
          .doc(id)
          .delete()
          .then((value) {
        setState(() {});
        print('unSaved');
      });
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  onLike() {
    print(likes);
    setState(() {
      likes.add(widget.user!.id!);
    });
    try {
      instance
          .collection('publish')
          .doc(widget.data.id)
          .collection('likedBets')
          .doc(widget.user!.id)
          .set({}).then((value) {
        setState(() {});
        print('liked');
        print(likes);
      });
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  onRemoveLike() {
    print(likes);
    setState(() {
      likes.remove(widget.user!.id!);
    });
    try {
      instance
          .collection('publish')
          .doc(widget.data.id)
          .collection('likedBets')
          .doc(widget.user!.id)
          .delete()
          .then((value) {
        print('unLiked');
        print(likes);
        setState(() {});
        print(likes);
      });
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }
}
