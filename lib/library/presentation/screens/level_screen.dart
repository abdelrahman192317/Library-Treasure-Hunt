import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../bloc/questions/questions_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utils/colors.dart';
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
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: top,
                elevation: 0,
                title: Text(
                  'المستوى ${levels[level]}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
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
                child: state.runtimeType == QuestionsFetchedSuccessfullyState
                    ? GridView.builder(
                        itemCount: myAllQuestions[difficulty][level].length,
                        padding: EdgeInsets.all(size.height * 0.005),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemBuilder: (ctx1, index) => QuestionCard(
                            diff: difficulty, level: level, question: index,
                        ),
                    ) : Center(
                        child: SpinKitFadingCircle(
                        color: Theme.of(context).primaryColor,
                        size: size.height * 0.1,
                      )),
              )),
        );
      },
    );
  }
}
