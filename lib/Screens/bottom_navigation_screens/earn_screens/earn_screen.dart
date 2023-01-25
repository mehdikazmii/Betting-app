import 'package:betting_app/Screens/bottom_navigation_screens/earn_screens/verify_bet_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/search_screen.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_round_button.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../entity/app_user.dart';
import '../../../helpers/add_manager.dart';
import '../../../helpers/constant.dart';
import '../../../helpers/screen_navigation.dart';
import '../../../provider/user_provider.dart';
import 'invite_friends.dart';

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key, required this.user, required this.userProvider});
  static String id = 'earn';
  final AppUser? user;
  final UserProvider? userProvider;

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  final adManager = AdManager();

  @override
  void initState() {
    adManager.addAds(true, true, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Image(
          image: AssetImage('assets/pbets.jpg'),
          height: 25,
        )),
        shadowColor: Colors.black,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(
              Icons.search,
              color: yellow,
              size: 25,
            ),
            onPressed: () => changeScreen(
                context,
                SearchScreen(
                  user: widget.user,
                ))),
        actions: [
          Row(
            children: [
              Text(
                widget.user!.wallet.toString(),
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
      backgroundColor: black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Invite and Earn',
                    style: TextStyle(
                        color: white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Watch an add',
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                          Text(
                            '+10 coins',
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: adManager.getBannerAd()?.size.width.toDouble(),
                      height: adManager.getBannerAd()?.size.height.toDouble(),
                      child: AdWidget(ad: adManager.getBannerAd()!),
                    ),
                    CRoundButton(
                        fontSize: 15,
                        height: 50,
                        width: 120,
                        textColor: black,
                        color: yellow,
                        function: () {
                          adManager.showRewardedAd(context);
                        },
                        text: 'Click to watch',
                        active: true),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, InviteFriends.id),
                            child: Text(
                              'Invite a friend',
                              style: TextStyle(color: white, fontSize: 17),
                            ),
                          ),
                          Text(
                            '+50 coins',
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'your friend has to introduce the code in profile/settings/referal',
                      style: TextStyle(color: white),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Code: @Ghevjjdhcblncljjhbddn',
                        style: TextStyle(color: white),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Verify Bets',
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                          Text(
                            '+25 coins',
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    CRoundButton(
                        fontSize: 15,
                        height: 50,
                        width: 120,
                        textColor: black,
                        color: yellow,
                        function: () {
                          widget.user!.verified
                              ? changeScreen(context, const VerifyBetSCreen())
                              : showSnackBar(
                                  'Reac level 10 to unlock this option',
                                  context);
                        },
                        text: 'Verify Bets',
                        active: true),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Instagram Stories',
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                          Text(
                            '+100 coins',
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    CRoundButton(
                        fontSize: 15,
                        height: 50,
                        width: 130,
                        textColor: black,
                        color: yellow,
                        function: () => showSnackBar(
                            'Take Screenshots and post on Instagram Story',
                            context),
                        text: 'Download Story',
                        active: true),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Post the download story in the instagram and tag @p-bets once you are verified you will get coins',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
