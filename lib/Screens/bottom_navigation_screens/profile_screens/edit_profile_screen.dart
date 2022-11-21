// ignore_for_file: avoid_print

import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_button.dart';
import 'package:betting_app/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shadowColor: black,
        backgroundColor: black,
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10),
          color: black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Change Name',
                color: yellow,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFE1E4E8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Change name',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.4))),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  buttonName: 'Change',
                  function: () => chnageName(),
                  height: 45,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomText(
                text: 'Change Country Name',
                color: yellow,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFE1E4E8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: countryController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Change Country',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.4))),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  buttonName: 'Change',
                  function: () => chnageCity(),
                  height: 45,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomText(
                text: 'Change Bio',
                color: yellow,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFE1E4E8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: bioController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Change Bio',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.4))),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  buttonName: 'Change',
                  function: () => chnageBio(),
                  height: 45,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  chnageName() {
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'name': nameController.text.toLowerCase()}).then((value) {
        showSnackBar('Name Changed', context);
        Navigator.pop(context);
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }

  chnageCity() {
    try {
      instance.collection('users').doc(auth.currentUser!.uid).update(
          {'country': countryController.text.toLowerCase()}).then((value) {
        showSnackBar('City Changed', context);
        Navigator.pop(context);
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }

  chnageBio() {
    try {
      instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'bio': bioController.text}).then((value) {
        showSnackBar('bio Changed', context);
        Navigator.pop(context);
      });
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
  }
}
