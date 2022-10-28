import 'package:betting_app/Screens/bottom_navigation_screens/invite_sub_screens/invite_friends.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../widgets/custom_round_button.dart';
import '../../../widgets/custom_text.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  static String id = 'report';

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController controller = TextEditingController();
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        shadowColor: black,
        backgroundColor: black,
        title: Text(
          'Report Bets',
          style: TextStyle(color: yellow),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomText(
                text: 'Report Bet',
                color: white,
                size: 20,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  icon: Icons.pending,
                  hint: 'Discuss the problem with the bet',
                  label: 'Discription',
                  controller: controller),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: 250,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: blue),
                child: const CustomText(
                  text: 'Repeated',
                  size: 20,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: 250,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: blue),
                child: const CustomText(
                  text: 'Offensive',
                  size: 20,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: 250,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: blue),
                child: const CustomText(
                  text: 'Scam',
                  size: 20,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: 250,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: blue),
                child: const CustomText(
                  text: 'Active Illegal',
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: CircleAvatar(
                          backgroundColor: blue,
                          child: Icon(
                            Icons.add,
                            color: white,
                          ))),
                  const CustomText(
                    text: 'Other Reason',
                    size: 23,
                    weight: FontWeight.bold,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'Created by',
                  size: 25,
                  weight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: blue,
                    child: Icon(
                      Icons.person,
                      color: white,
                    ),
                  ),
                  const CustomText(
                    text: 'Pepito27',
                  ),
                  CRoundButton(
                    function: () {},
                    text: 'Report',
                    color: yellow,
                    fontSize: 17,
                    width: 120,
                    textColor: black,
                    height: 50,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
