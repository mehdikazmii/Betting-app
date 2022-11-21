// ignore_for_file: avoid_print

import 'package:betting_app/Screens/bottom_navigation_screens/add_bet_screens/add_bet_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/earn_screens/earn_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/prize_screens/prize_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/search_screen.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/widgets/custom_modal_progress_hud.dart';
import 'package:betting_app/widgets/drawer.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../entity/app_user.dart';
import '../../helpers/constant.dart';
import '../../provider/user_provider.dart';
import 'home_screens/home_screen.dart';
import 'profile_screens/profile_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);
  static String id = 'navigaationScreenId';

  @override
  State<BottomNavigationScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomNavigationScreen> {
  final PageController controller = PageController(initialPage: 0);
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens(userProvider, AppUser user) {
      print('Mehdi received the dataa------------');
      print(user.email);

      return [
        HomeScreen(
          user: user,
          userProvider: userProvider,
        ),
        EarnScreen(
          user: user,
          userProvider: userProvider,
        ),
        AddBetScreen(
          user: user,
        ),
        PrizeScreen(
          user: user,
          userProvider: userProvider,
        ),
        ProfileScreen(
          user: user,
          userProvider: userProvider,
        ),
      ];
    }

    return Scaffold(
        bottomNavigationBar: CustomNavigationBar(
            backgroundColor: black,
            scaleFactor: 0.2,
            scaleCurve: Curves.linear,
            bubbleCurve: Curves.linear,
            selectedColor: yellow,
            strokeColor: Colors.black12,
            elevation: 16,
            currentIndex: pageIndex,
            onTap: (index) {
              setState(() {
                pageIndex = index;
                controller.animateToPage(pageIndex,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.linearToEaseOut);
              });
            },
            iconSize: 29,
            items: [
              CustomNavigationBarItem(icon: const Icon(Icons.home)),
              CustomNavigationBarItem(icon: const Icon(Icons.group)),
              CustomNavigationBarItem(
                icon: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: Icon(Icons.add, color: yellow)),
              ),
              CustomNavigationBarItem(
                  icon: const Icon(Icons.card_giftcard_sharp)),
              CustomNavigationBarItem(icon: const Icon(Icons.person)),
            ]),
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
          return FutureBuilder<AppUser?>(
              future: userProvider.user,
              builder: (context, userSnapshot) {
                return CustomModalProgressHUD(
                    inAsyncCall: userProvider.isLoading,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      onPageChanged: (index) {
                        setState(() {
                          pageIndex = index;
                        });
                      },
                      children: buildScreens(
                          userProvider,
                          userSnapshot.hasData
                              ? userSnapshot.data!
                              : AppUser(
                                  id: '',
                                  username: '',
                                  profilePhotoPath: '',
                                  country: '',
                                  email: '')),
                    )
                    // : PageView(
                    //     scrollDirection: Axis.horizontal,
                    //     controller: controller,
                    //     onPageChanged: (index) {
                    //       setState(() {
                    //         pageIndex = index;
                    //       });
                    //     },
                    //     children: screens(),
                    //   ),
                    );
              });
        }));
  }
}
