import 'package:betting_app/bottom_navigation_screens/add_bet_screen.dart';
import 'package:betting_app/bottom_navigation_screens/cash_screen.dart';
import 'package:betting_app/bottom_navigation_screens/gift_screen.dart';
import 'package:betting_app/widgets/drawer.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../helpers/constant.dart';
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
    List<Widget> buildScreens() {
      return [
        const HomeScreen(),
        const CashScreen(),
        const AddBetScreen(),
        const GiftScreen(),
        const ProfileScreen(),
      ];
    }

    return Scaffold(
      drawer: const Drawerr(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'P-BETS',
            style: TextStyle(color: yellow),
          ),
        ),
        shadowColor: black,
        backgroundColor: black,
        leading: pageIndex != 0
            ? IconButton(
                icon: Icon(
                  Icons.search,
                  color: yellow,
                  size: 25,
                ),
                onPressed: () {})
            : Builder(builder: (BuildContext context) {
                return IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Icon(
                      Icons.menu,
                      color: yellow,
                    ));
              }),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Row(
                children: [
                  Text(
                    '123',
                    style: TextStyle(
                        color: yellow,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: buildScreens(),
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
            CustomNavigationBarItem(icon: const Icon(Icons.money)),
            CustomNavigationBarItem(
              icon: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Icon(Icons.add, color: yellow)),
            ),
            CustomNavigationBarItem(icon: const Icon(Icons.price_change)),
            CustomNavigationBarItem(icon: const Icon(Icons.person)),
          ]),
    );
  }
}
