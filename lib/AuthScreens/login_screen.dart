import 'package:betting_app/AuthScreens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../bottom_navigation_screens/bottom_navigation_screen.dart';
import '../helpers/constant.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool check(bool b) {
    setState(() {
      isChecked == true ? isChecked = false : true;
    });
    return isChecked;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body:
            // StreamBuilder<User?>(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return const BottomNavigationScreen();
            //     } else {
            SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.2,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Image(
                          image: AssetImage('assets/logo.png'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        'Hello!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      const Text(
                        'Sign in to your account',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      // const SizedBox(height: 15),
                      SizedBox(
                        height: 190,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              fillColor:
                                  MaterialStateProperty.all(Colors.white),
                              value: isChecked,
                              onChanged: (b) {
                                setState(() {
                                  isChecked = b ?? false;
                                });
                              }),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 150,
                            child: const Text(
                              'Remeber me',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, ForgotPasswordScreen.id),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        buttonName: 'Log In',
                        width: 300,
                        height: 50,
                        function: () {
                          // signIn();
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, BottomNavigationScreen.id);
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text('OR',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      const SizedBox(height: 10),
                      CustomButton(
                        buttonName: 'Sign in with facebook',
                        textColor: Colors.white,
                        width: 300,
                        height: 50,
                        function: () {},
                        color: Colors.blue,
                      ),

                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () =>
                            {Navigator.pushNamed(context, SignpScreen.id)},
                        child: const Text.rich(TextSpan(
                            text: 'Dont have an account?  ',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //    );
          //   }
          //  },
          // ),
        ));
  }

  // Future signIn() async {
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
  //         .signInWithEmailAndPassword(
  //             email: emailController.text.trim(),
  //             password: passwordController.text.trim())
  //         .then((value) {
  //       flag = false;
  //       Navigator.pushNamed(context, BottomNavigationScreen.id);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     showToast(
  //       '${e.message}',
  //       duration: const Duration(seconds: 2),
  //       position: ToastPosition.center,
  //       backgroundColor: Colors.white.withOpacity(0.8),
  //       radius: 3.0,
  //       textStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
  //       textPadding: const EdgeInsets.all(10),
  //     );
  //     setState(() {
  //       flag = false;
  //     });
  //   }
  // }
}
