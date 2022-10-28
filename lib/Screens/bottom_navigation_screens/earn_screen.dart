// import 'package:betting_app/widgets/custom_round_button.dart';
// import 'package:flutter/material.dart';
// import '../../helpers/constant.dart';
// import 'invite_sub_screens/invite_friends.dart';

// class EarnScreen extends StatelessWidget {
//   const EarnScreen({super.key});
//   static String id = 'earn';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: black,
//         backgroundColor: black,
//         title: Text(
//           'Invite and Earn',
//           style: TextStyle(color: yellow),
//         ),
//       ),
//       backgroundColor: black,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Invite and Earn',
//                     style: TextStyle(
//                         color: white,
//                         fontSize: 23,
//                         fontWeight: FontWeight.bold),
//                   )),
//               Container(
//                 width: MediaQuery.of(context).size.width / 1.5,
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Watch an add',
//                             style: TextStyle(color: white, fontSize: 17),
//                           ),
//                           Text(
//                             '+30 coins',
//                             style: TextStyle(color: white, fontSize: 17),
//                           ),
//                         ],
//                       ),
//                     ),
//                     CRoundButton(
//                         fontSize: 15,
//                         height: 50,
//                         width: 120,
//                         textColor: black,
//                         color: yellow,
//                         function: () {},
//                         text: 'Click to watch',
//                         active: true),
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () =>
//                                 Navigator.pushNamed(context, InviteFriends.id),
//                             child: Text(
//                               'Invite a friend',
//                               style: TextStyle(color: white, fontSize: 17),
//                             ),
//                           ),
//                           Text(
//                             '+50 coins',
//                             style: TextStyle(color: white, fontSize: 17),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       'your friend has to introduce the code in profile/settings/referal',
//                       style: TextStyle(color: white),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 20),
//                       child: Text(
//                         'Code:@Juawn Funds',
//                         style: TextStyle(color: white),
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Verify Bets',
//                             style: TextStyle(color: white, fontSize: 17),
//                           ),
//                           Text(
//                             '+80 coins',
//                             style: TextStyle(color: white, fontSize: 17),
//                           ),
//                         ],
//                       ),
//                     ),
//                     CRoundButton(
//                         fontSize: 15,
//                         height: 50,
//                         width: 120,
//                         textColor: black,
//                         color: yellow,
//                         function: () {},
//                         text: 'Verify Bets',
//                         active: true),
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Instagram Stories',
//                             style: TextStyle(color: white, fontSize: 17),
//                           ),
//                           Text(
//                             '+150 coins',
//                             style: TextStyle(color: white, fontSize: 17),
//                           ),
//                         ],
//                       ),
//                     ),
//                     CRoundButton(
//                         fontSize: 15,
//                         height: 50,
//                         width: 130,
//                         textColor: black,
//                         color: yellow,
//                         function: () {},
//                         text: 'Dawnload Story',
//                         active: true),
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       child: const Text(
//                         'Post the dawnload story in the instagram and tag @p-bets once you are verified you will get coins',
//                         style: TextStyle(
//                           color: Colors.grey,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
