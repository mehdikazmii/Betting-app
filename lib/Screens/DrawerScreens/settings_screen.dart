import 'package:betting_app/helpers/constant.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  static String id = 'settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        shadowColor: black,
        backgroundColor: black,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: white,
            )),
        title: const Text('Setting'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'data',
              style: TextStyle(color: white),
            ),
          ],
        ),
      ),
    );
  }
}
