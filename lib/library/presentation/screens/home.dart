import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:workmanager/workmanager.dart';

import '../../core/utils/functions.dart';
import '../../bloc/connection/connection_bloc.dart';
import '../../bloc/questions/questions_bloc.dart';
import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import '../widgets/ads_button.dart';
import 'levels.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Timer _timer;


  @override
  void initState() {
    Workmanager().registerPeriodicTask("a", "b");
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) => valuesBloc.add(AddHeartCountEvent()));
    super.initState();
  }


  @override
  void dispose() {
    player.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ConnectionBloc, ConnectivityState>(
      builder: (context, cState) {
        return cState.runtimeType == NoConnectionState ? Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/svg/connection.svg',
                  height: size.height * 0.28,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  'لا يوجد اتصال بالإنترنت',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
        ) : BlocBuilder<ValuesBloc, ValuesState>(
      builder: (context, state) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: RefreshIndicator(
                onRefresh: () => Future.delayed(const Duration(seconds: 0),
                    () => questionsBloc.add(FetchAllQuestionsEvent())),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(size.height * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.02),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ...List.generate(
                                    state.runtimeType ==
                                            ValuesFetchedSuccessfullyState
                                        ? heartCount!
                                        : 5,
                                    (index) => Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.01,
                                              top: size.width * 0.03),
                                          child: Image.asset(
                                            'assets/images/heart.png',
                                            height: size.height * 0.03,
                                          ),
                                        )),
                              ]),
                        ),
                        SizedBox(height: size.height * 0.05),
                        SizedBox(
                          height: size.height * 0.28,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Text(
                          'اختر مستوى الاسئلة',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: size.height * 0.02),
                        _difficultyButton(size, 0, 'سهل', Colors.green),
                        SizedBox(height: size.height * 0.01),
                        _difficultyButton(
                            size, 1, 'متوسط', Theme.of(context).canvasColor),
                        SizedBox(height: size.height * 0.01),
                        _difficultyButton(
                            size, 2, 'صعب', Theme.of(context).primaryColor),
                        SizedBox(height: size.height * 0.02),
                        if (heartCount! < 5) ...[
                          // Display timer if heart count is less than 5
                          const Text(
                            'يمكنك الحصول على قلب جديد كل 10 دقائق او ...',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: size.height * 0.01),

                          const AdsButton(answer: 'إضـافة قلــوب'),
                          SizedBox(height: size.height * 0.05),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ));
      });});
  }

  _navigate(int dif) {
    player.setAudioSource(AudioSource.asset('assets/audio/click.mp3'))
        .then((value) => player.play().then((value) => Navigator.push(
            context, MaterialPageRoute(
                builder: (context) => BlocProvider<ValuesBloc>.value(
                    value: valuesBloc,
                    child: BlocProvider<QuestionsBloc>.value(
                      value: questionsBloc,
                      child: Levels(difficulty: dif),
                    ))))));
  }

  Widget _difficultyButton(Size size, int dif, String text, Color color) =>
      SizedBox(
        width: size.width,
        height: size.height * 0.08,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          onPressed: () => _navigate(dif),
          child: Text(text, style: context.getThemeTextStyle().titleLarge),
        ),
      );
}
