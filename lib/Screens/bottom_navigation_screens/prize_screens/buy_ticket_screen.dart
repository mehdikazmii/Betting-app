// ignore_for_file: avoid_print

import 'package:betting_app/Screens/bottom_navigation_screens/bottom_navigation_screen.dart';
import 'package:betting_app/entity/app_user.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_modal_progress_hud.dart';
import 'package:betting_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../widgets/custom_round_button.dart';

class BuyTicketScreen extends StatefulWidget {
  const BuyTicketScreen({super.key, required this.data, required this.user});
  final QueryDocumentSnapshot<Object?> data;
  final AppUser? user;

  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  int _currentValue = 0;
  double totalPrice = 0;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text('Buy Tickets'),
        shadowColor: black,
        backgroundColor: black,
      ),
      body: CustomModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: black,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Tickets to buy',
                size: 25,
              ),
              Column(
                children: [
                  CustomText(
                    size: 20,
                    text: widget.data['title'],
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image:
                          CachedNetworkImageProvider(widget.data['image_path']),
                      fit: BoxFit.cover,
                      height: 220,
                      width: 220,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    size: 20,
                    text:
                        '${widget.data['sold']}/${widget.data['tickets']} ticket',
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    size: 20,
                    text: '${widget.data['price']} coins',
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const CustomText(
                        text: 'N Tickets',
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: white),
                            borderRadius: BorderRadius.circular(10)),
                        child: NumberPicker(
                          selectedTextStyle:
                              TextStyle(color: yellow, fontSize: 20),
                          textStyle: TextStyle(color: white),
                          value: _currentValue,
                          minValue: 0,
                          maxValue: int.parse(widget.data['tickets']) -
                              int.parse(widget.data['sold'].toString()),
                          onChanged: (value) => setState(() {
                            _currentValue = value;
                            totalPrice = double.parse(
                                (int.parse(widget.data['price']) *
                                        _currentValue)
                                    .toString());
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: 'Total: $totalPrice',
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/coin.png',
                            color: white,
                            height: 30,
                          ),
                        ],
                      ),
                      int.parse(widget.data['tickets']) -
                                  int.parse(widget.data['sold'].toString()) !=
                              0
                          ? CRoundButton(
                              color: yellow,
                              width: 100,
                              function: () {
                                _currentValue != 0
                                    ? totalPrice <= widget.user!.wallet
                                        ? redeem(
                                            widget.user!.wallet - totalPrice)
                                        : showSnackBar(
                                            'Not have enough coins', context)
                                    : showSnackBar(
                                        'Select tickets to buy', context);
                              },
                              text: 'Redeem',
                              textColor: black,
                            )
                          : CRoundButton(
                              function: () {},
                              text: 'Ended',
                              color: Colors.grey,
                            ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  redeem(updatedWallet) {
    print(updatedWallet);
    setState(() {
      _isLoading = true;
    });
    try {
      instance
          .collection('users')
          .doc(widget.user!.id)
          .update({'wallet': updatedWallet}).then((value) {
        instance
            .collection('tickets')
            .doc(widget.data.id)
            .collection('buyers')
            .doc(widget.user!.id)
            .set({}).then((value) {
          instance
              .collection('tickets')
              .doc(widget.data.id)
              .get()
              .then((value) {
            List buyers = value['buyers'];
            for (int i = 0; i < _currentValue; i++) {
              buyers.add(widget.user!.id);
            }
            int sold = value['sold'] + _currentValue;
            instance
                .collection('tickets')
                .doc(widget.data.id)
                .update({'buyers': buyers, 'sold': sold}).then((value) {
              instance
                  .collection('users')
                  .doc(widget.user!.id)
                  .collection('myTickets')
                  .doc(widget.data.id)
                  .set({});
              showSnackBar('Tickets have been purchased', context);
              setState(() {
                _isLoading = false;
              });
              Navigator.pop(context);
              changeScreen(
                  context,
                  const BottomNavigationScreen(
                    pageIndex: 3,
                  ));
            });
          });
        });
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }
}
