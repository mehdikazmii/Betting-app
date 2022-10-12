import 'package:flutter/material.dart';

import 'AuthScreens/email_verification_screen.dart';
import 'AuthScreens/forgot_password_screen.dart';
import 'AuthScreens/login_screen.dart';
import 'AuthScreens/signup_screen.dart';
import 'AuthScreens/success_screen.dart';
import 'bottom_navigation_screens/bottom_navigation_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  BottomNavigationScreen.id: (context) => const BottomNavigationScreen(),
  LoginScreen.id: (context) => const LoginScreen(),
  SignpScreen.id: (context) => const SignpScreen(),
  EmailVerificationScreen.id: (context) => const EmailVerificationScreen(),
  SuccessScreen.id: (context) => const SuccessScreen(),
  ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
};
