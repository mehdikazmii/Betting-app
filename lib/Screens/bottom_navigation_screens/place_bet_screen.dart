// ignore_for_file: avoid_print

import 'package:betting_app/helpers/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helpers/screen_navigation.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text.dart';
import 'report_screens/report_screen.dart';

class PLaceBetScreen extends StatefulWidget {
  const PLaceBetScreen({super.key, required this.data});
  static String id = 'home';
  final QueryDocumentSnapshot data;

  @override
  State<PLaceBetScreen> createState() => _PLaceBetScreenState();
}

class _PLaceBetScreenState extends State<PLaceBetScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: black, body: card(context, widget.data));
  }

  Padding card(BuildContext context, QueryDocumentSnapshot data) {
    DateTime dateTime = DateTime.parse(data['dateTime'].toDate().toString());
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
                        function: () {},
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
