import 'package:betting_app/Screens/DrawerScreens/referal_code_screen.dart';
import 'package:betting_app/Screens/DrawerScreens/settings_screen.dart';
import 'package:betting_app/Screens/bottom_navigation_screens/earn_screens/invite_friends.dart';
import 'package:flutter/material.dart';

import 'Screens/AuthScreens/email_verification_screen.dart';
import 'Screens/AuthScreens/login_screen.dart';
import 'Screens/AuthScreens/signup_screen.dart';
import 'Screens/AuthScreens/success_screen.dart';
import 'Screens/AuthScreens/forgot_password_screen.dart';
import 'Screens/bottom_navigation_screens/bottom_navigation_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  BottomNavigationScreen.id: (context) => const BottomNavigationScreen(),
  LoginScreen.id: (context) => const LoginScreen(),
  SignpScreen.id: (context) => const SignpScreen(),
  EmailVerificationScreen.id: (context) => const EmailVerificationScreen(),
  SuccessScreen.id: (context) => const SuccessScreen(),
  ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
  InviteFriends.id: (context) => const InviteFriends(),
};
