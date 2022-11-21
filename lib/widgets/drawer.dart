import 'package:betting_app/Screens/DrawerScreens/referal_code_screen.dart';
import 'package:betting_app/Screens/DrawerScreens/settings_screen.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/provider/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../Screens/AuthScreens/login_screen.dart';
import '../entity/app_user.dart';

class Drawerr extends StatefulWidget {
  Drawerr({Key? key, this.user}) : super(key: key);

  final AppUser? user;

  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  final UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: white,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: yellow),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(widget.user!.profilePhotoPath!),
                backgroundColor: Colors.grey,
                radius: 40,
              ),
              arrowColor: Colors.white,
              accountName: Text(
                widget.user!.username.toString(),
                style: TextStyle(color: black),
              ),
              accountEmail: Text(
                widget.user!.email.toString(),
                style: TextStyle(color: black),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                changeScreen(
                    context,
                    SettingScreen(
                      user: widget.user,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money_outlined),
              title: const Text('Referal Code'),
              onTap: () {
                changeScreen(
                    context, InviteScreen(referalCode: widget.user!.id));
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
