import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_round_button.dart';
import '../../../widgets/custom_text.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key, required this.data, required this.name});
  static String id = 'report';
  final String? name;
  final QueryDocumentSnapshot<Object?> data;
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController controller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  String selected = '';
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
              GestureDetector(
                onTap: () {
                  selected = 'repeated';
                  showSnackBar(selected, context);
                },
                child: Container(
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
              ),
              GestureDetector(
                onTap: () {
                  selected = 'offensive';
                  showSnackBar(selected, context);
                },
                child: Container(
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
              ),
              GestureDetector(
                onTap: () {
                  selected = 'scam';
                  showSnackBar(selected, context);
                },
                child: Container(
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
              ),
              GestureDetector(
                onTap: () {
                  selected = 'active Illegal';
                  showSnackBar(selected, context);
                },
                child: Container(
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
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        selected = 'other reason';
                        showSnackBar(selected, context);
                      },
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
                  CustomText(
                    text: widget.data['name'],
                  ),
                  CRoundButton(
                    function: () {
                      selected != ''
                          ? reportBet(controller.text.trim(), selected)
                          : showSnackBar('Please select any option', context);
                    },
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

  reportBet(explaination, report) {
    try {
      instance
          .collection('publish')
          .doc(widget.data.id)
          .collection('reports')
          .doc(auth.currentUser!.uid)
          .set({
        'explaination': explaination,
        'report': report,
        'name': widget.name
      }).then((value) {
        Navigator.pop(context);
        showSnackBar('Bet has been reported', context);
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }
}
