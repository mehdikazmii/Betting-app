import 'package:betting_app/widgets/custom_round_button.dart';
import 'package:betting_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../../helpers/constant.dart';
import 'invite_sub_screens/invite_friends.dart';

class PrizeScreen extends StatelessWidget {
  const PrizeScreen({super.key});
  static String id = 'cash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                text: 'Tickets to buy',
                size: 25,
                weight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [Card(), Card(), Card()],
                  ),
                  Column(
                    children: const [Card(), Card(), Card()],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const CustomText(
            text: '10E Paypal',
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: white),
            child: const Image(
              image: AssetImage('assets/paypal.png'),
              height: 80,
              width: 80,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const CustomText(
            text: '43/100 ventus',
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          const CustomText(
            text: '100 coins',
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          CRoundButton(
            function: () {},
            text: 'CONJEAR',
            color: yellow,
            textColor: black,
          )
        ],
      ),
    );
  }
}
