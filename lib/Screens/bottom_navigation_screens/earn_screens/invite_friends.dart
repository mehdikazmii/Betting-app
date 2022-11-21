import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/widgets/custom_round_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({super.key});
  static String id = '';

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  List<String> followers = [];
  List<bool> _isChecked = [];

  @override
  void initState() {
    getFollowers();
    super.initState();
  }

  getFollowers() {
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('followers')
          .get()
          .then((value) {
        for (var element in value.docs) {
          followers.add(element.id);
        }
        instance.collection('users').get().then(
          (value) {
            _isChecked = List<bool>.filled(value.docs.length, false);
            print(_isChecked);
          },
        );
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        shadowColor: black,
        backgroundColor: black,
        title: Text(
          'Invite Friends',
          style: TextStyle(color: yellow),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Container(
              height: height / 1.3,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    var item = snapshot.data!.docs;

                    print(_isChecked);
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = item[index];
                        return followers.contains(data.id)
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  textColor: white,
                                  trailing: Checkbox(
                                      activeColor: white,
                                      checkColor: black,
                                      value: _isChecked[index],
                                      onChanged: (onChnaged) {
                                        setState(() {
                                          _isChecked[index] = onChnaged!;
                                        });
                                      }),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    backgroundImage: CachedNetworkImageProvider(
                                        data['profile_photo_path']),
                                  ),
                                  title: Text(
                                    data['name'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    (data['bio'] == null || data['bio'] == "")
                                        ? "No bio"
                                        : data['bio'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            : Container();
                      },
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            CRoundButton(
              function: () => Navigator.pop(context),
              text: 'Invite',
              active: true,
              color: yellow,
              textColor: black,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}



// Expanded(
//               child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemCount: 20,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Container(
//                       margin: const EdgeInsets.symmetric(vertical: 2),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10)),
//                       child: ListTile(
//                           leading: CircleAvatar(backgroundColor: white),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: CRoundButton(
//                               active: true,
//                               function: () {},
//                               text: 'follow',
//                               height: 30,
//                               width: 80,
//                               fontSize: 10,
//                             ),
//                           ),
//                           trailing: CRoundButton(
//                             active: true,
//                             function: () {},
//                             text: 'remove',
//                             height: 30,
//                             width: 80,
//                             fontSize: 10,
//                           ),
//                           title: Text(
//                             "@john Wick",
//                             style: TextStyle(color: white),
//                           )),
//                     );
//                   }),
//             ),