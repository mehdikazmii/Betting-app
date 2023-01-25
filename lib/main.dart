import 'package:betting_app/Screens/splash_screen.dart';
import 'package:betting_app/provider/user_provider.dart';
import 'package:betting_app/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'helpers/shared_preferences_utils.dart';

//EB99A1151BCFA1C8E61252807F2A1DF9
//90c2b524-8958-4ab1-b699-2a11be100974
List<String> testDeviceIds = ['FE5AD9753B9F9774A4C248B48554F4FB'];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // thing to add
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);
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
          home: const SplashScreen(),
          routes: routes,
        ));
  }
}
