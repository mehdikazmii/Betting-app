import 'package:betting_app/helpers/constant.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static String id = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int i = 0;
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    height: height / 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const ClipRRect(
                                child: Image(
                                  image: AssetImage('assets/girl1.png'),
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              Text(
                                'Regina Pablo',
                                style: TextStyle(color: white, fontSize: 15),
                              ),
                              const Text(
                                'Bio',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.emoji_events_outlined,
                                      color: yellow,
                                    ),
                                    Text(
                                      'Level 23',
                                      style:
                                          TextStyle(color: white, fontSize: 15),
                                    ),
                                    Text(
                                      '-',
                                      style: TextStyle(
                                          color: yellow,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '20',
                                          style: TextStyle(
                                              color: white, fontSize: 15),
                                        ),
                                        Text(
                                          'Following',
                                          style: TextStyle(
                                              color: white, fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '350',
                                          style: TextStyle(
                                              color: white, fontSize: 15),
                                        ),
                                        Text(
                                          'Followers',
                                          style: TextStyle(
                                              color: white, fontSize: 15),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Edit Profile',
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.send_outlined,
                                          color: white,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CRoundButton(
                              active: true,
                              function: () {},
                              text: 'Active Bets',
                            ),
                            CRoundButton(
                              active: true,
                              function: () {},
                              text: 'History',
                            )
                          ],
                        ),
                        Container(
                          height: height / 2.32,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: 20,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        decoration: BoxDecoration(
                                            color: blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                            // tileColor: blue,
                                            subtitle: Text(
                                              'Barca - Madrid',
                                              style: TextStyle(color: white),
                                            ),
                                            trailing: Text(
                                              "10000",
                                              style: TextStyle(
                                                  color: white, fontSize: 15),
                                            ),
                                            title: Text(
                                              "Why will win the party",
                                              style: TextStyle(color: white),
                                            )),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}

class CRoundButton extends StatelessWidget {
  const CRoundButton({
    Key? key,
    required this.function,
    required this.text,
    required this.active,
  }) : super(key: key);
  final Function function;
  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: active ? blue : Colors.grey,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: TextStyle(color: white, fontSize: 18),
        ),
      ),
    );
  }
}
