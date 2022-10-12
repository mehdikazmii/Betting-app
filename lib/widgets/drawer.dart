import 'package:betting_app/helpers/constant.dart';
import 'package:flutter/material.dart';
import '../AuthScreens/login_screen.dart';

class Drawerr extends StatelessWidget {
  const Drawerr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: white,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: yellow),
              currentAccountPicture: const CircleAvatar(
                foregroundImage: AssetImage('assets/girl1.png'),
                backgroundColor: Colors.white,
              ),
              arrowColor: Colors.white,
              accountName: const Text('Mehdi'),
              accountEmail: const Text('someone@mail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, LoginScreen.id);
              },
            )
          ],
        ));
  }
}
