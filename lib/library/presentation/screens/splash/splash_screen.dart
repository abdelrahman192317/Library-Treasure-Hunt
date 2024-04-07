import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
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
    questionsBloc.add(FetchAllQuestionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedSplashScreen(
      duration: 1500,
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
        child: Hero(
          tag: 'splash',
          child: Image.asset(
              'assets/images/logo.png',
              width: size.width * 0.7,
              height: size.height * 0.7,
              alignment: Alignment.center,
              fit: BoxFit.contain
          ),
        ),
      ),
      nextScreen: BlocProvider(
        create: (context) => ConnectionBloc()..add(InitialConnectionEvent()),
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