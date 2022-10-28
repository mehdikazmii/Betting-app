import 'package:betting_app/widgets/custom_round_button.dart';
import 'package:flutter/material.dart';
import '../../helpers/constant.dart';
import 'invite_sub_screens/invite_friends.dart';

class EarnScreen extends StatelessWidget {
  const EarnScreen({super.key});
  static String id = 'earn';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   shadowColor: black,
      //   backgroundColor: black,
      //   title: Text(
      //     'Invite and Earn',
      //     style: TextStyle(color: yellow),
      //   ),
      // ),
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
                            '+30 coins',
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
                        function: () {},
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
                        'Code:@Juawn Funds',
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
                            '+80 coins',
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
                        function: () {},
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
                            '+150 coins',
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
                        function: () {},
                        text: 'Dawnload Story',
                        active: true),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Post the dawnload story in the instagram and tag @p-bets once you are verified you will get coins',
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


// import 'package:betting_app/Screens/bottom_navigation_screens/report_screens/report_screen.dart';
// import 'package:betting_app/helpers/constant.dart';
// import 'package:betting_app/helpers/screen_navigation.dart';
// import 'package:betting_app/widgets/custom_round_button.dart';
// import 'package:flutter/material.dart';

// import '../../widgets/custom_text.dart';

// class PrivateFeedScreen extends StatefulWidget {
//   const PrivateFeedScreen({super.key});
//   static String id = 'cash';

//   @override
//   State<PrivateFeedScreen> createState() => _PrivateFeedScreenState();
// }

// class _PrivateFeedScreenState extends State<PrivateFeedScreen> {
//   bool saved = false;
//   bool liked = false;
//   bool shared = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: black,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 const CustomText(
//                   text: 'Match Winner',
//                   size: 20,
//                 ),
//                 IconButton(
//                     onPressed: () =>
//                         changeScreen(context, const ReportScreen()),
//                     icon: CircleAvatar(
//                         radius: 20,
//                         backgroundColor: blue,
//                         child: Center(
//                             child: Icon(
//                           Icons.warning_rounded,
//                           color: white,
//                         ))))
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CRoundButton(function: () {}, text: 'BARCA', active: true),
//                 const CustomText(
//                   text: 'X 2.1',
//                   size: 20,
//                   weight: FontWeight.bold,
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CRoundButton(function: () {}, text: 'MADRID', active: true),
//                 const CustomText(
//                   text: 'X 1.9',
//                   size: 20,
//                   weight: FontWeight.bold,
//                 )
//               ],
//             ),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: CustomText(
//                 text: 'Ends',
//                 weight: FontWeight.bold,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: const [
//                 CustomText(
//                   text: '23/08/22  10:00 PM',
//                 ),
//                 CustomText(
//                   text: '2.989',
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: blue,
//                         child: Icon(
//                           Icons.person,
//                           color: white,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       CRoundButton(
//                         function: () {},
//                         text: '@pepito',
//                         textColor: black,
//                         active: true,
//                         fontSize: 12,
//                         height: 40,
//                         width: 90,
//                       )
//                     ],
//                   ),
//                 ),
//                 CRoundButton(
//                   function: () {},
//                   text: 'APOSTAR',
//                   color: yellow,
//                   textColor: black,
//                   fontSize: 17,
//                   width: 120,
//                   height: 50,
//                 )
//               ],
//             ),
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(10)),
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomText(
//                     text: 'Fixed Comment..',
//                     size: 16,
//                     color: black,
//                   ),
//                   Row(
//                     children: [
//                       CustomText(
//                         text: '44',
//                         size: 16,
//                         color: black,
//                       ),
//                       const SizedBox(width: 10),
//                       Icon(
//                         Icons.insert_comment_rounded,
//                         color: black,
//                         size: 18,
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     CustomText(
//                       text: '12',
//                       color: blue,
//                       size: 25,
//                       weight: FontWeight.bold,
//                     ),
//                     const CustomText(
//                       text: 'Sub',
//                       weight: FontWeight.bold,
//                       size: 18,
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 30,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: Row(
//                     children: [
//                       const CustomText(text: '23'),
//                       IconButton(
//                           splashRadius: 5.0,
//                           onPressed: () {
//                             setState(() {
//                               liked ? liked = false : liked = true;
//                             });
//                           },
//                           icon: liked
//                               ? const Icon(Icons.favorite, color: Colors.red)
//                               : Icon(
//                                   Icons.favorite_border,
//                                   color: white,
//                                 ))
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: Row(
//                     children: [
//                       const CustomText(text: '23'),
//                       IconButton(
//                         splashRadius: 5.0,
//                         onPressed: () {
//                           setState(() {
//                             shared ? shared = false : shared = true;
//                           });
//                         },
//                         icon: Icon(
//                           Icons.loop,
//                           color: shared ? blue : white,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                     child: IconButton(
//                       splashRadius: 5.0,
//                       icon: Icon(
//                         Icons.collections_bookmark_outlined,
//                         color: saved ? blue : white,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           saved ? saved = false : saved = true;
//                         });
//                       },
//                     ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
