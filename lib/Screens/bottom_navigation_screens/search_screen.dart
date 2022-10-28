import 'dart:convert';

import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_textfield.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        shadowColor: black,
        backgroundColor: black,
        title: Text(
          'Search',
          style: TextStyle(color: yellow),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  icon: Icons.pending,
                  hint: 'Search',
                  label: 'Search',
                  controller: controller),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: blue,
                        child: Icon(
                          Icons.local_fire_department_outlined,
                          color: white,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustomText(
                      text: 'Trending Bets',
                      weight: FontWeight.bold,
                      size: 23,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: const [
                    NewRow(text: 'Manellu vs Vic', points: '1.239 Co'),
                    NewRow(text: 'Barca vs Liverpool', points: '1.239 Co'),
                    NewRow(text: 'Deva nemra meroco', points: '1.239 Co'),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: blue,
                        child: Icon(
                          Icons.emoji_events_outlined,
                          color: white,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustomText(
                      text: 'Top players of the week',
                      weight: FontWeight.bold,
                      size: 23,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: const [
                    NewRow(text: 'pepito', points: '1.239 Co'),
                    NewRow(text: 'Tombasbislu', points: '1.239 Co'),
                    NewRow(text: 'osamabinladin', points: '1.239 Co'),
                    NewRow(text: 'gentop2006', points: '1.239 Co'),
                    NewRow(text: 'ahmed', points: '1.239 Co'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  const NewRow({
    Key? key,
    required this.points,
    required this.text,
  }) : super(key: key);
  final String text;
  final String points;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text,
          ),
          CustomText(
            text: points,
          )
        ],
      ),
    );
  }
}
