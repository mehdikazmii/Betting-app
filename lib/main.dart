import 'package:betting_app/Screens/splash_screen.dart';
import 'package:betting_app/provider/user_provider.dart';
import 'package:betting_app/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/shared_preferences_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  checkIfUserExists();
  runApp(const MyApp());
}

Future<void> checkIfUserExists() async {
  String? userId = await SharedPreferencesUtil.getUserId();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'P-Bets',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          routes: routes,
        ));
  }
}
