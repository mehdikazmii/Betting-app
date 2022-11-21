// ignore_for_file: avoid_print

import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_round_button.dart';
import '../../../widgets/custom_text.dart';

class BetCardScreen extends StatefulWidget {
  const BetCardScreen({super.key, required this.data});
  final QueryDocumentSnapshot<Object?> data;

  @override
  State<BetCardScreen> createState() => _BetCardScreenState();
}

class _BetCardScreenState extends State<BetCardScreen> {
  String selected = '';
  bool isLoading = false;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateTime.parse(widget.data['dateTime'].toDate().toString());
    return Scaffold(
        appBar: AppBar(
            shadowColor: black,
            backgroundColor: black,
            title: const Text(
              'Bet',
            )),
        body: CustomModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            color: black,
            padding: const EdgeInsets.all(10.0),
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
                                print(selected);
                              },
                              text: widget.data['option1'],
                              active: true),
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
                                print(selected);
                              },
                              text: widget.data['option2'],
                              active: true),
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
                                      print(selected);
                                    },
                                    text: widget.data['option3'],
                                    active: true),
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
                          dateTime.isAfter(DateTime.now())
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
                                              "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                                        ),
                                        CustomText(
                                          text:
                                              '${dateTime.hour}:${dateTime.minute}',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      text: widget.data['name'],
                                      active: true,
                                      fontSize: 12,
                                      height: 40,
                                      width: 90,
                                    )
                                  ],
                                ),
                              ),
                              dateTime.isAfter(DateTime.now())
                                  ? CRoundButton(
                                      function: () {},
                                      text: 'Remove',
                                      textColor: black,
                                      color: Colors.grey,
                                      fontSize: 17,
                                      width: 120,
                                      height: 50,
                                    )
                                  : CRoundButton(
                                      function: () {
                                        selected == ''
                                            ? showSnackBar(
                                                'please select the correct option',
                                                context)
                                            : verifyBet(context);
                                      },
                                      text: 'Verify',
                                      color: Colors.green,
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
                                  text: widget.data['comment'],
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
                            ],
                          ),
                        ]))
              ],
            ),
          ),
        ));
  }

  verifyBet(context) {
    setState(() {
      isLoading = true;
    });
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshots = instance
          .collection('publish')
          .doc(widget.data.id)
          .collection('placeBet')
          .snapshots();
      snapshots.forEach((elements) {
        for (var element in elements.docs) {
          if (element['option'] == selected) {
            addPoints(element);
          } else {
            removePoints(element);
          }
        }
      });
      removeBetAndAddToHistory();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  addPoints(QueryDocumentSnapshot<Map<String, dynamic>> element) async {
    try {
      var data = await instance.collection('users').doc(element.id).get();
      double wallet = data['wallet'] + element['result'];
      instance
          .collection('users')
          .doc(element.id)
          .update({'wallet': wallet})
          .then((value) => print('points have been added'))
          .onError((error, stackTrace) => print(error.toString()));
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  removePoints(element) async {
    try {
      var data = await instance.collection('users').doc(element.id).get();
      double wallet = data['wallet'] - int.parse(element['bet']);
      instance
          .collection('users')
          .doc(element.id)
          .update({'wallet': wallet})
          .then((value) => print('points have been removed'))
          .onError((error, stackTrace) => print(error.toString()));
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  removeBetAndAddToHistory() async {
    print('------------');
    try {
      await instance
          .collection('publish')
          .doc(widget.data.id)
          .get()
          .then((value) {
        instance
            .collection('users')
            .doc(widget.data['uid'])
            .collection('history')
            .doc(widget.data.id)
            .set(value.data()!);
      }).then((value) {
        instance.collection('publish').doc(widget.data.id).get().then(((value) {
          value.reference.delete();
        })).then((value) {
          instance
              .collection('users')
              .doc(auth.currentUser!.uid)
              .get()
              .then((snapshot) {
            double wallet = snapshot['wallet'] + 80;
            instance
                .collection('users')
                .doc(auth.currentUser!.uid)
                .update({'wallet': wallet}).then((value) {});
          });
          Navigator.pop(context);
          print('document deleted');
        });

        print('added to history');
        showSnackBar('Result has been published', context);
      });
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString(), context);
    }
  }
}
