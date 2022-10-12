// ignore_for_file: avoid_print

import 'package:betting_app/AuthScreens/email_verification_screen.dart';
import 'package:betting_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import '../helpers/constant.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class SignpScreen extends StatefulWidget {
  const SignpScreen({Key? key}) : super(key: key);
  static String id = 'signup';

  @override
  State<SignpScreen> createState() => _SignpScreenState();
}

class _SignpScreenState extends State<SignpScreen> {
  bool isChecked = false;
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // final user = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
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
        key: formKey,
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
                  controller: nameController,
                  icon: Icons.abc_rounded,
                  hint: 'your Username',
                  label: 'Username',
                  textInputAction: TextInputAction.next,
                ),
                CustomTextField(
                  controller: userNameController,
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Checkbox(
                //         activeColor: Colors.white,
                //         checkColor: Colors.black,
                //         fillColor: MaterialStateProperty.all(Colors.white),
                //         value: isChecked,
                //         onChanged: (b) {
                //           setState(() {
                //             isChecked = b ?? false;
                //           });
                //         }),
                //     const Expanded(
                //       child: Text.rich(TextSpan(
                //           text: 'By checking this you agree to ',
                //           style: TextStyle(fontSize: 13, color: Colors.white),
                //           children: <InlineSpan>[
                //             TextSpan(
                //               text: 'Privacy Policy ',
                //               style: TextStyle(
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.white),
                //             ),
                //             TextSpan(
                //               text: 'and ',
                //               style:
                //                   TextStyle(fontSize: 13, color: Colors.white),
                //             ),
                //             TextSpan(
                //               text: 'Terms & Conditions',
                //               style: TextStyle(
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.white),
                //             )
                //           ])),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),
                CustomButton(
                  buttonName: 'Sign up',
                  width: 300,
                  height: 50,
                  function: () {
                    // String name = nameController.text.trim();
                    // dynamic userName = userNameController.text;
                    // name != '' && userName != ''
                    //     ? signUp(name, userName)
                    //     : showText('Add your name and User-Name');
                    Navigator.pushNamed(context, EmailVerificationScreen.id);
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

  // Future signUp(String name, dynamic userName) async {
  //   final isValid = formKey.currentState!.validate();
  //   if (!isValid) return;
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
  //         .createUserWithEmailAndPassword(
  //             email: emailController.text.trim(),
  //             password: passwordController.text.trim())
  //         .then(
  //       (value) async {
  //         flag = false;
  //         String email = user.currentUser!.email!;
  //         dynamic uid = user.currentUser!.uid;
  //         Map<String, dynamic> userInfo = {
  //           'uid': uid,
  //           'name': name,
  //           'userName': userName,
  //           'email': email,
  //         };
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: ((builder) => EmailVerificationScreen(
  //                   user: userInfo,
  //                 )),
  //           ),
  //         );
  //       },
  //     );
  //   } on FirebaseException catch (e) {
  //     print(e);
  //     setState(() {
  //       flag = false;
  //     });
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
