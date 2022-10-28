import 'package:betting_app/Screens/bottom_navigation_screens/add_bet_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/private_feed_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/prize_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screen.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/widgets/custom_modal_progress_hud.dart';
import 'package:betting_app/widgets/drawer.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../entity/app_user.dart';
import '../../helpers/constant.dart';
import '../../provider/user_provider.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

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
        const HomeScreen(),
        const EarnScreen(),
        AddBetScreen(
          user: user,
        ),
        const PrizeScreen(),
        ProfileScreen(
          user: user,
          userProvider: userProvider,
        ),
      ];
    }

    return Scaffold(
        drawer: Drawerr(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Center(
              child: Image(
            image: AssetImage('assets/pbets.jpg'),
            height: 25,
          )),
          shadowColor: Colors.black,
          backgroundColor: Colors.black,
          leading: pageIndex != 0
              ? IconButton(
                  icon: Icon(
                    Icons.search,
                    color: yellow,
                    size: 25,
                  ),
                  onPressed: () => changeScreen(context, SearchScreen()))
              : Builder(builder: (BuildContext context) {
                  return IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Icon(
                        Icons.menu,
                        color: yellow,
                      ));
                }),
          actions: [
            Row(
              children: [
                Text(
                  '123',
                  style: TextStyle(
                      color: white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Image(
                      image: const AssetImage(
                        'assets/black-coin.png',
                      ),
                      color: yellow,
                      height: 20,
                      width: 20,
                    ))
              ],
            )
          ],
        ),
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
                                  city: '',
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
