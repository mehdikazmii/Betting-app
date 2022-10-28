// ignore_for_file: avoid_print

import 'package:betting_app/Screens/AuthScreens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../helpers/constant.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  static String id = 'forgotPasswordScreen';
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: Icon(
            Icons.arrow_back,
            color: yellow,
          ),
          title: Text(
            'Forgot Password',
            style: TextStyle(color: yellow),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
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
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Enter your Email to reset Your Password',
                    style: TextStyle(color: white, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                      icon: Icons.email,
                      hint: 'Email',
                      label: 'Email',
                      controller: emailController),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomButton(
                      buttonName: 'Reset Password',
                      width: 230,
                      height: 50,
                      function: () {
                        // resetPassword(context);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, LoginScreen.id);
                      })
                ],
              ),
            ),
          ),
        ));
  }

  // Future resetPassword(context) async {
  //   bool flag = true;
  //   flag == true
  //       ? showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (context) => const Center(
  //                 child: CircularProgressIndicator(
  //                   color: Colors.white,
  //                 ),
  //               ))
  //       : null;
  //   try {
  //     await FirebaseAuth.instance
  //         .sendPasswordResetEmail(email: emailController.text.trim())
  //         .then((value) {
  //       showText('Password Reset Email sent to your Email');
  //       flag = false;
  //       Navigator.pushNamed(context, LoginScreen.id);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     showText(e.message!);
  //   }
  // }

  // showText(String text) {
  //   showToast(
  //     text,
  //     duration: const Duration(seconds: 2),
  //     position: ToastPosition.center,
  //     backgroundColor: Colors.white.withOpacity(0.8),
  //     radius: 3.0,
  //     textStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
  //     textPadding: const EdgeInsets.all(10),
  //   );
  // }
}
