// ignore_for_file: avoid_print

import 'package:betting_app/Screens/bottom_navigation_screens/home_screens/bet_home_card.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../entity/app_user.dart';
import '../../../helpers/screen_navigation.dart';
import '../../../provider/user_provider.dart';
import '../search_screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user, required this.userProvider});
  static String id = 'home';
  final AppUser? user;
  final UserProvider? userProvider;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Image(
            image: AssetImage('assets/pbets.jpg'),
            height: 25,
          )),
          shadowColor: Colors.black,
          backgroundColor: Colors.black,
          leading: IconButton(
              icon: Icon(
                Icons.search,
                color: yellow,
                size: 25,
              ),
              onPressed: () => changeScreen(
                  context,
                  SearchScreen(
                    user: widget.user,
                  ))),
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

              return Swiper(
                itemBuilder: (BuildContext context, int index) {
                  var data = item[index];
                  DateTime dateTime =
                      DateTime.parse(data['dateTime'].toDate().toString());
                  return BetHomeCard(
                    data: data,
                    user: widget.user,
                    dateTime: dateTime,
                  );
                },
                itemCount: snapshot.data!.docs.length,
                pagination:
                    const SwiperPagination(builder: SwiperPagination.rect),
                // control: SwiperControl(),
                scrollDirection: Axis.vertical,
              );
            }));
  }
}
