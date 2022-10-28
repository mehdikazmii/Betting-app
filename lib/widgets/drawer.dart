import 'package:betting_app/Screens/DrawerScreens/referal_code_screen.dart';
import 'package:betting_app/Screens/DrawerScreens/settings_screen.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import '../Screens/AuthScreens/login_screen.dart';

class Drawerr extends StatelessWidget {
  final UserProvider userProvider = UserProvider();
  Drawerr({
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
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, SettingScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money_outlined),
              title: const Text('Referal Code'),
              onTap: () {
                Navigator.pushNamed(context, InviteScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log out'),
              onTap: () {
                userProvider.logoutUser();
                Navigator.pop(context);
                Navigator.pushNamed(context, LoginScreen.id);
              },
            )
          ],
        ));
  }
}
