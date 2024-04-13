import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../../../bloc/connection/connection_bloc.dart';
import '../../../bloc/questions/questions_bloc.dart';
import '../../../core/global/global.dart';
import '../../../core/utilities/colors.dart';
import '../add_name/add_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    questionsBloc = QuestionsBloc();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedSplashScreen(
      duration: 500,
      splashIconSize: size.height,
      splash: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [background, canvas],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'splash',
              child: Image.asset('assets/images/logo.png', height: size.height * 0.8),
            ),
            SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: size.height * 0.15,
            ),
          ],
        ),
      ),
      nextScreen: BlocProvider(
        create: (context) => ConnectionBloc()..add(InitialConnectionEvent()),
        child: BlocProvider(
          create: (context) => questionsBloc..add(FetchAllQuestionsEvent()),
          child: const AddName(),
        ),
      ),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}