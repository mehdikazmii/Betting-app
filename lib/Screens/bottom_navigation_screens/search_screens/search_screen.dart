// ignore_for_file: avoid_print

import 'package:betting_app/Screens/bottom_navigation_screens/home_screens/bet_home_card.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/bet_search_card.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/search_screens/user_card_screen.dart';
import 'package:betting_app/entity/app_user.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import '../../../helpers/constant.dart';
import '../../../widgets/custom_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.user}) : super(key: key);
  static String id = 'search';
  final AppUser? user;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? name;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          shadowColor: black,
          title: const Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFE1E4E8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    onChanged: ((value) {
                      setState(() {
                        name = value.toString();
                      });
                    }),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search name',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.4))),
                  ),
                ),
              ),
              (name == null || name == '')
                  ? const Expanded(
                      child: InfoResult(
                        info: 'No results',
                      ),
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('name', isEqualTo: name)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Expanded(
                              child: InfoResult(
                            info: 'Loading...',
                          ));
                        }
                        if (listEquals(snapshot.data!.docs, [])) {
                          return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('publish')
                                  .where('def', isEqualTo: name)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Expanded(
                                      child: InfoResult(
                                    info: 'Loading...',
                                  ));
                                }
                                if (listEquals(snapshot.data!.docs, [])) {
                                  return const Expanded(
                                      child: InfoResult(
                                    info: 'No match found',
                                  ));
                                }
                                List<Widget> widgetsList = [];
                                for (var document in snapshot.data!.docs) {
                                  DateTime dateTime = DateTime.parse(
                                      document['dateTime'].toDate().toString());
                                  var widgets = ListTile(
                                    textColor: white,
                                    onTap: (() {
                                      changeScreen(
                                          context,
                                          BetSearchCard(
                                              data: document,
                                              user: widget.user,
                                              dateTime: dateTime));
                                    }),
                                    title: Text(
                                      document['def'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      '@${document['name']}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                  widgetsList.add(widgets);
                                }

                                return Expanded(
                                  child: ListView(
                                    children: widgetsList,
                                  ),
                                );
                              });
                        }
                        print('printing data list');
                        print(snapshot.data!.docs);
                        List<Widget> widgetsList = [];
                        for (var i in snapshot.data!.docs) {
                          var document = i.data() as Map;
                          if (document['id'] == uid) continue;
                          var widget = ListTile(
                            textColor: white,
                            onTap: (() {
                              changeScreen(
                                  context, UserCardScreen(userData: document));
                            }),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              backgroundImage: CachedNetworkImageProvider(
                                  document['profile_photo_path']),
                            ),
                            title: Text(
                              document['name'],
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              (document['bio'] == null || document['bio'] == "")
                                  ? "No bio"
                                  : document['bio'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                          widgetsList.add(widget);
                        }

                        return Expanded(
                          child: ListView(
                            children: widgetsList,
                          ),
                        );
                      })
            ],
          ),
        ));
  }
}

class InfoResult extends StatelessWidget {
  const InfoResult({Key? key, this.info}) : super(key: key);

  final info;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: (Platform.isIOS)
          ? EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 14 / 100)
          : EdgeInsets.zero,
      child: Text(
        info,
        style: const TextStyle(color: Colors.white),
      ),
    ));
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

// import 'dart:convert';

// import 'package:betting_app/helpers/constant.dart';
// import 'package:betting_app/widgets/custom_text.dart';
// import 'package:flutter/material.dart';

// import '../../widgets/custom_textfield.dart';

// class SearchScreen extends StatelessWidget {
//   SearchScreen({super.key});
//   final TextEditingController controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: black,
//       appBar: AppBar(
//         shadowColor: black,
//         backgroundColor: black,
//         title: Text(
//           'Search',
//           style: TextStyle(color: yellow),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 10,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomTextField(
//                   icon: Icons.pending,
//                   hint: 'Search',
//                   label: 'Search',
//                   controller: controller),
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 20),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                         backgroundColor: blue,
//                         child: Icon(
//                           Icons.local_fire_department_outlined,
//                           color: white,
//                         )),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const CustomText(
//                       text: 'Trending Bets',
//                       weight: FontWeight.bold,
//                       size: 23,
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: const [
//                     NewRow(text: 'Manellu vs Vic', points: '1.239 Co'),
//                     NewRow(text: 'Barca vs Liverpool', points: '1.239 Co'),
//                     NewRow(text: 'Deva nemra meroco', points: '1.239 Co'),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 20),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                         backgroundColor: blue,
//                         child: Icon(
//                           Icons.emoji_events_outlined,
//                           color: white,
//                         )),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const CustomText(
//                       text: 'Top players of the week',
//                       weight: FontWeight.bold,
//                       size: 23,
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: const [
//                     NewRow(text: 'pepito', points: '1.239 Co'),
//                     NewRow(text: 'Tombasbislu', points: '1.239 Co'),
//                     NewRow(text: 'osamabinladin', points: '1.239 Co'),
//                     NewRow(text: 'gentop2006', points: '1.239 Co'),
//                     NewRow(text: 'ahmed', points: '1.239 Co'),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class NewRow extends StatelessWidget {
  const NewRow({
    Key? key,
    required this.points,
    required this.text,
  }) : super(key: key);
  final String text;
  final String points;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text,
          ),
          CustomText(
            text: points,
          )
        ],
      ),
    );
  }
}
