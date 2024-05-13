import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'firebase_options.dart';

import 'library/core/global/global.dart';
import 'library/core/utils/themes.dart';
import 'library/data/repos/local.dart';
import 'library/presentation/screens/splash_screen.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try{
      await LocalManager.getHeartCount();
      LocalManager.addHeartCount();
    }catch(e){
      debugPrint(e.toString());
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedPreferences = await SharedPreferences.getInstance();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      title: 'Treasure Hunt',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
