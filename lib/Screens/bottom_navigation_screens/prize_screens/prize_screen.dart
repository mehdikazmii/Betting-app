import 'package:betting_app/Screens/bottom_navigation_screens/prize_screens/buy_ticket_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/prize_screens/my_tickets_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/search_screen.dart';
import 'package:betting_app/widgets/custom_round_button.dart';
import 'package:betting_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../entity/app_user.dart';
import '../../../helpers/constant.dart';
import '../../../helpers/screen_navigation.dart';
import '../../../provider/user_provider.dart';

class PrizeScreen extends StatelessWidget {
  const PrizeScreen(
      {super.key, required this.user, required this.userProvider});
  static String id = 'cash';
  final AppUser? user;
  final UserProvider? userProvider;
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
                  user: user,
                ))),
        actions: [
          Row(
            children: [
              Text(
                user!.wallet.toString(),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                children: [
                  const CustomText(
                    text: 'Tickets to buy',
                    size: 25,
                    weight: FontWeight.bold,
                  ),
                  IconButton(
                      onPressed: () => changeScreen(
                          context,
                          MyTicketsScreen(
                            user: user,
                          )),
                      icon: Icon(
                        Icons.auto_awesome_motion_sharp,
                        color: white,
                        size: 23,
                      ))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.4,
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

                      return GridView.builder(
                        itemCount: item.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, mainAxisExtent: 250),
                        itemBuilder: (BuildContext context, int index) {
                          var data = item[index];

                          return Card(
                            data: data,
                            user: user,
                          );
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

class Card extends StatelessWidget {
  const Card({Key? key, required this.data, required this.user})
      : super(key: key);

  final QueryDocumentSnapshot<Object?> data;
  final AppUser? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: data['title'],
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: CachedNetworkImageProvider(data['image_path']),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(
          text: '${data['sold']}/${data['tickets']} ticket',
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 5,
        ),
        CustomText(
          text: '${data['price']} coins',
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 5,
        ),
        int.parse(data['tickets']) - int.parse(data['sold'].toString()) != 0
            ? CRoundButton(
                color: yellow,
                width: 100,
                function: () => changeScreen(
                    context, BuyTicketScreen(data: data, user: user)),
                text: 'Redeem',
                textColor: black,
              )
            : CRoundButton(
                function: () {},
                text: 'Ended',
                width: 100,
                color: Colors.grey,
              )
      ],
    );
  }
}
