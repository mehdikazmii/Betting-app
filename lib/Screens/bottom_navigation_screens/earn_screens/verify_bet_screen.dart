import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'bet_card_screen.dart';

class VerifyBetSCreen extends StatelessWidget {
  const VerifyBetSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Bets'),
      ),
      backgroundColor: black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
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
                  DateTime dateTime =
                      DateTime.parse(data['dateTime'].toDate().toString());
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        color: dateTime.isAfter(DateTime.now())
                            ? blue
                            : Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                        onTap: () =>
                            changeScreen(context, BetCardScreen(data: data)),
                        subtitle: Text(
                          "${data['option1']} - ${data['option2']}",
                          style: TextStyle(color: white),
                        ),
                        trailing: Text(
                          data['totalBet'] == '' ? '0' : data['totalBet'],
                          style: TextStyle(color: white, fontSize: 15),
                        ),
                        title: Text(
                          data['def'],
                          style: TextStyle(color: white),
                        )),
                  );
                },
              );
            }),
      ),
    );
  }
}
