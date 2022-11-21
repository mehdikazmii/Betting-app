// ignore_for_file: avoid_print

import 'package:betting_app/Screens/bottom_navigation_screens/prize_screens/buy_ticket_screen.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_round_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../entity/app_user.dart';
import '../../../helpers/constant.dart';
import '../../../widgets/custom_text.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key, required this.user});
  final AppUser? user;
  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  List<String> tickets = [];
  @override
  void initState() {
    getTicketInfo();
    super.initState();
  }

  getTicketInfo() {
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('myTickets')
          .get()
          .then((value) {
        for (var element in value.docs) {
          tickets.add(element.id);
        }
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }

  int getTickets(List buyers) {
    int ticketCount = 0;
    for (int i = 0; i < buyers.length; i++) {
      buyers[i] == auth.currentUser!.uid ? ticketCount++ : null;
    }
    return ticketCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: black,
        backgroundColor: black,
        title: const Text('My Tickets'),
      ),
      body: Container(
        color: black,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CustomText(
                    text: 'My Tickets',
                    size: 25,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('tickets')
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
                        itemCount: item.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = item[index];

                          return tickets.contains(data.id)
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: data['title'],
                                            weight: FontWeight.bold,
                                            size: 20,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image(
                                              image: CachedNetworkImageProvider(
                                                  data['image_path']),
                                              fit: BoxFit.cover,
                                              height: 130,
                                              width: 130,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text:
                                                '${getTickets(data['buyers']).toString()} Tickets',
                                            weight: FontWeight.bold,
                                          ),
                                          CustomText(
                                            text:
                                                '${data['sold']}/${data['tickets']} ticket',
                                            weight: FontWeight.bold,
                                          ),
                                          CustomText(
                                            text: data['winner'] == 'In process'
                                                ? data['winner']
                                                : 'winner: @${data['winner']}',
                                            weight: FontWeight.bold,
                                          ),
                                          data['winner'] == 'In process'
                                              ? int.parse(data['tickets']) -
                                                          int.parse(data['sold']
                                                              .toString()) !=
                                                      0
                                                  ? CRoundButton(
                                                      color: yellow,
                                                      textColor: black,
                                                      function: () =>
                                                          changeScreen(
                                                              context,
                                                              BuyTicketScreen(
                                                                data: data,
                                                                user:
                                                                    widget.user,
                                                              )),
                                                      text: 'Redeem')
                                                  : CRoundButton(
                                                      function: () {},
                                                      text: 'Ended',
                                                      color: Colors.grey,
                                                    )
                                              : data['winner'] ==
                                                      '${widget.user!.username}'
                                                  ? CRoundButton(
                                                      color: Colors.green,
                                                      textColor: white,
                                                      function: () => showSnackBar(
                                                          'The admin will give you prize manually',
                                                          context),
                                                      text: 'Get Prize')
                                                  : CRoundButton(
                                                      color: yellow,
                                                      textColor: black,
                                                      function: () => showSnackBar(
                                                          'You will get the discounted code',
                                                          context),
                                                      text: 'Get Discount')
                                        ],
                                      )
                                    ],
                                  ))
                              : Container();
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
