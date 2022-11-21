import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({super.key, required this.referalCode});
  static String id = 'earn';
  final String? referalCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: white,
            )),
        title: const Text('Referal Code'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: CustomText(
              size: 15,
              text:
                  'Click on code to copy and send it to your friend, he will add this code to his referal code section and you will get your reward',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: referalCode)).then(
                  (value) => showSnackBar(
                      '$referalCode copied to clip board', context));
            },
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Referal code : $referalCode',
                style: TextStyle(color: white),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
