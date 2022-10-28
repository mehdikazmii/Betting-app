// ignore_for_file: avoid_print

import 'package:betting_app/Models/user_registration.dart';
import 'package:betting_app/Screens/AuthScreens/add_photo_screen.dart';
import 'package:betting_app/helpers/screen_navigation.dart';
import 'package:betting_app/helpers/utils.dart';
import 'package:betting_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helpers/constant.dart';
import '../../widgets/custom_button.dart';
import 'login_screen.dart';

class SignpScreen extends StatefulWidget {
  const SignpScreen({Key? key}) : super(key: key);
  static String id = 'signup';

  @override
  State<SignpScreen> createState() => _SignpScreenState();
}

class _SignpScreenState extends State<SignpScreen> {
  bool isChecked = false;
  final cityController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  UserRegistration userRegistration = UserRegistration();
  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();

    super.dispose();
  }

  bool check(bool b) {
    setState(() {
      isChecked == true ? isChecked = false : true;
    });
    return isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Form(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                      color: yellow, borderRadius: BorderRadius.circular(15)),
                  child: const Image(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign up!',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const Text(
                  'Create Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: userNameController,
                  icon: Icons.abc_rounded,
                  hint: 'your Username',
                  label: 'Username',
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  controller: cityController,
                  icon: Icons.location_city,
                  hint: 'your city',
                  label: 'City',
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  controller: emailController,
                  icon: Icons.person,
                  hint: 'someone@mail.com',
                  label: 'Email',
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  controller: passwordController,
                  icon: Icons.lock,
                  hint: 'Password',
                  label: 'Password',
                  suffixIcon: Icons.remove_red_eye_outlined,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  controller: confirmPassController,
                  icon: Icons.lock,
                  hint: 'Confirm Password',
                  label: 'Confirm Password',
                  suffixIcon: Icons.remove_red_eye_outlined,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  buttonName: 'Continue',
                  width: 300,
                  height: 50,
                  function: () {
                    userRegistration.username = userNameController.text.trim();
                    userRegistration.email = emailController.text.trim();
                    userRegistration.city = cityController.text.trim();
                    userRegistration.password = passwordController.text.trim();
                    userRegistration.username.isEmpty ||
                            userRegistration.city.isEmpty ||
                            userRegistration.email.isEmpty ||
                            userRegistration.password.isEmpty
                        ? showSnackBar('Fill all the fields', context)
                        : changeScreen(context,
                            AddPhotoScreen(userRegistration: userRegistration));
                  },
                ),
                const SizedBox(height: 15),
                const Text('OR',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(height: 5),
                const Text('Continue with',
                    style: TextStyle(color: Colors.grey, fontSize: 17)),
                const SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const []),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, LoginScreen.id)},
                  child: Text.rich(TextSpan(
                      text: 'Have an account?  ',
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: yellow),
                        )
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
