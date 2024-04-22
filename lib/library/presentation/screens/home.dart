import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../bloc/questions/questions_bloc.dart';
import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import 'add_question/add_question.dart';
import 'levels.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(minutes: 2),
            (Timer t) => valuesBloc.add(AddHeartCountEvent()));
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () => Future.delayed(
                const Duration(milliseconds: 0),
                    () => questionsBloc.add(FetchAllQuestionsEvent())),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.05),
                    SizedBox(
                      height: size.height * 0.28,
                      child: Image.asset('assets/images/logo.png',
                        width: size.width, fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: size.height * 0.1),

                    Text('إختر مستوي الاسئلة',
                      style: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(height: size.height * 0.02),

                    _difficultyButton(size, 0, 'سهل', Colors.green),
                    SizedBox(height: size.height * 0.01),
                    _difficultyButton(size, 1, 'متوسط', Theme.of(context).canvasColor),
                    SizedBox(height: size.height * 0.01),
                    _difficultyButton(size, 2, 'صعب', Theme.of(context).primaryColor),

                    SizedBox(height: size.height * 0.05),

                    SizedBox(
                      width: size.width,
                      height: size.height * 0.08,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const AddQuestion(),
                        )),
                        child:  Text('إضافة سؤال',style: context.getThemeTextStyle().titleLarge),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  _navigate(int dif) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => BlocProvider<ValuesBloc>.value(
        value: valuesBloc,
        child: BlocProvider<QuestionsBloc>.value(
          value: questionsBloc,
          child: Levels(difficulty: dif),
        ))));

  Widget _difficultyButton(Size size, int dif, String text, Color color) => SizedBox(
    width: size.width,
    height: size.height * 0.08,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: () => _navigate(dif),
      child:  Text(text,style: context.getThemeTextStyle().titleLarge),
    ),
  );

}