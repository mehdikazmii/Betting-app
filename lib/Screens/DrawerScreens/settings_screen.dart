// ignore_for_file: avoid_print

import 'package:betting_app/Screens/DrawerScreens/follow_requests.dart';
import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/remote/firebase_database_source.dart';
import 'package:betting_app/widgets/custom_button.dart';
import 'package:betting_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../entity/app_user.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key, required this.user});
  static String id = 'settings';
  final AppUser? user;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  bool? isSwitched;
  String? name;

  @override
  void initState() {
    isSwitched = widget.user!.private;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: black,
        backgroundColor: black,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: white,
            )),
        title: const Text('Setting'),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: black,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          changeScreen(context, const FollowRequestsScreen()),
                      child: const CustomText(
                        text: 'Follow Requests',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: 'Public/Private Account',
                        ),
                        FlutterSwitch(
                          activeText: "private",
                          inactiveText: "public",
                          activeTextColor: Colors.white,
                          inactiveTextColor: Colors.white,
                          showOnOff: true,
                          width: 110.0,
                          height: 45.0,
                          toggleSize: 45.0,
                          value: isSwitched!,
                          borderRadius: 30.0,
                          padding: 2.0,
                          activeToggleColor: Colors.blue,
                          inactiveToggleColor: Colors.grey,
                          activeSwitchBorder: Border.all(
                            color: Colors.blue,
                            width: 6.0,
                          ),
                          inactiveSwitchBorder: Border.all(
                            color: Colors.grey,
                            width: 6.0,
                          ),
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey,
                          activeIcon: const Icon(Icons.lock),
                          inactiveIcon: const Icon(Icons.lock_open_rounded),
                          onToggle: (val) {
                            setState(() {
                              isSwitched = val;
                              widget.user!.private = val;
                              print(widget.user!.private);
                              private(isSwitched);
                            });
                          },
                        ),
                      ],
                    ),
                    !widget.user!.refered
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const CustomText(
                                  text: 'Referal Code',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFE1E4E8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: TextField(
                                      onChanged: ((value) {
                                        setState(() {
                                          name = value;
                                        });
                                      }),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: 'Search name',
                                          hintStyle: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.4))),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomButton(
                                  buttonName: 'Apply',
                                  function: () {
                                    name != null
                                        ? addReferalPoints(name)
                                        : showSnackBar(
                                            'Add referal code', context);
                                  },
                                  height: 40,
                                )
                              ],
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              'Referred',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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

  addReferalPoints(name) async {
    try {
      instance.collection('users').doc(name).get().then((snapshot) {
        double wallet = snapshot['wallet'] + 50;
        instance
            .collection('users')
            .doc(widget.user!.id)
            .update({'refered': true}).then((value) {
          instance
              .collection('users')
              .doc(name)
              .update({'wallet': wallet}).then((value) {
            showSnackBar('Referal code added', context);
            setState(() {
              widget.user!.refered = true;
            });
          });
        });
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }

  private(value) {
    instance
        .collection('users')
        .doc(widget.user!.id)
        .update({'private': isSwitched}).then((value) {
      showSnackBar('The account has been set to private', context);
      setState(() {
        widget.user!.private = true;
      });
    });
  }
}
