import 'package:betting_app/helpers/constant.dart';
import 'package:flutter/material.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({super.key});
  static String id = 'earn';
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
        child: Column(),
      ),
    );
  }
}
