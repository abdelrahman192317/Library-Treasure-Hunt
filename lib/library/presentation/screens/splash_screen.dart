import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../../bloc/ads_bloc/ads_bloc.dart';
import '../../bloc/questions/questions_bloc.dart';
import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utils/colors.dart';
import 'add_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    adsBloc = AdsBloc();

    valuesBloc = ValuesBloc();
    valuesBloc.add(GetNameEvent());
    valuesBloc.add(GetHeartCountEvent());

    questionsBloc = QuestionsBloc();
    questionsBloc.add(FetchAllQuestionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedSplashScreen(
      duration: 1000,
      splashIconSize: size.height,
      splash: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [top, bottom],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'splash',
              child: Image.asset('assets/images/logo.png', width: size.width ,height: size.height * 0.4),
            ),
            SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: size.height * 0.12,
            ),
          ],
        ),
      ),
      nextScreen: BlocProvider<ValuesBloc>.value(
        value: valuesBloc,
        child: BlocProvider(
          create: (context) => questionsBloc,
          child: const AddName(),
        ),
      ),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}