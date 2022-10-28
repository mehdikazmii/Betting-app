import 'package:betting_app/helpers/constant.dart';
import 'package:flutter/material.dart';

import 'fingureprint_api.dart';

class FingerprintPage extends StatefulWidget {
  FingerprintPage({Key? key, required this.routeNmae}) : super(key: key);
  String routeNmae;

  @override
  State<FingerprintPage> createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> {
  @override
  void initState() {
    authenticate();
    super.initState();
  }

  authenticate() async {
    final isAuthenticated = await LocalAuthApi.authenticate();

    if (isAuthenticated) {
      Navigator.pushNamed(context, widget.routeNmae);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                buildAuthenticate(context),
              ],
            ),
          ),
        ),
      );

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () {
          authenticate();
        },
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: yellow,
          minimumSize: const Size.fromHeight(50),
        ),
        icon: Icon(
          icon,
          size: 26,
          color: black,
        ),
        label: Text(
          text,
          style: TextStyle(fontSize: 20, color: black),
        ),
        onPressed: onClicked,
      );
}
