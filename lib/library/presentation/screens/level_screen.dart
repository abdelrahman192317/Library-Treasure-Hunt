import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../bloc/questions/questions_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utilities/colors.dart';
import '../widgets/question_card.dart';

class LevelScreen extends StatelessWidget {
  final int difficulty, level;

  const LevelScreen({super.key, required this.difficulty, required this.level});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (ctx, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: top,
              elevation: 0,
              actions: [
                Padding(
                  padding: EdgeInsets.all(size.height * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(state.runtimeType == QuestionsFetchedSuccessfullyState)
                        Text(
                            '${myAllSolvedQuestions[difficulty][level].length}',
                            style: context.getThemeTextStyle().titleLarge),
                      Image.asset('assets/images/key.png',width: size.height * 0.05),
                    ],
                  ),
                ),
              ],
              title: Text('المستوى ${levels[level]}'),
              centerTitle: true,
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [top, bottom],
                ),
              ),
              child: state.runtimeType == QuestionsFetchedSuccessfullyState?
                GridView.builder(
                  itemCount: myAllQuestions[difficulty][level].length,
                  padding: EdgeInsets.all(size.height * 0.005),
                  itemBuilder: (ctx1, index) => QuestionCard(
                      difficulty: difficulty, level: level, question: index),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ))
                : Center(child: SpinKitFadingCircle(
                color: Theme.of(context).primaryColor,
                size: size.height * 0.1,
              )),
            )
          ),
        );
      },
    );
  }
}
