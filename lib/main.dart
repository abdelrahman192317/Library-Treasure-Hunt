import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:library_treasure_hunt/library/bloc/ads_bloc/ads_bloc.dart';
import 'package:library_treasure_hunt/library/bloc/values/values_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'library/bloc/questions/questions_bloc.dart';
import 'library/core/global/global.dart';
import 'library/core/utilities/themes.dart';
import 'library/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuestionsBloc(),
        ),
        BlocProvider(
          create: (context) => ValuesBloc(),
        ),
        BlocProvider(
          create: (context) => AdsBloc(),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('ar'),
        debugShowCheckedModeBanner: false,
        title: 'Treasure Hunt',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
