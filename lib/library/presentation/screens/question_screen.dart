import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utilities/colors.dart';
import '../../data/models/questions_model.dart';
import '../widgets/answer_card.dart';


class QuestionScreen extends StatelessWidget {
  final int difficulty, level, question;
  final Question q;
  const QuestionScreen({super.key, required this.difficulty, required this.level, required this.question, required this.q});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ValuesBloc, ValuesState>(
      builder: (context, state) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Row(
                      children: List.generate( state.runtimeType == ValuesFetchedSuccessfullyState?
                        heartCount! : 3, (index) => Padding(
                        padding:  EdgeInsets.only(right:size.width * 0.01),
                        child: Image.asset('assets/images/heart.png', height: size.height * 0.03),
                      ),
                      )
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding:  EdgeInsets.symmetric(horizontal: size.width*25/430),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                      width: size.width,
                      child: Card(
                        color: primary,
                        child: Center(
                          child: FittedBox(
                            child: Text(q.question, style: context.getThemeTextStyle().titleLarge),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height* 0.05),

                    AnswerCard(answer: q.answer_1, rightAnswer: q.rightAnswer,
                    difficulty: difficulty, level: level, question: question,),
                    AnswerCard(answer: q.answer_2, rightAnswer: q.rightAnswer,
                      difficulty: difficulty, level: level, question: question,),
                    AnswerCard(answer: q.answer_3, rightAnswer: q.rightAnswer,
                      difficulty: difficulty, level: level, question: question,),
                    AnswerCard(answer: q.answer_4, rightAnswer: q.rightAnswer,
                      difficulty: difficulty, level: level, question: question,),

                    SizedBox(height: size.height * 0.05),

                    AnswerCard(answer: 'مساعدة', rightAnswer: q.rightAnswer,
                      difficulty: difficulty, level: level, question: question, isHelp: true),
                  ],
                ),
              ),
            )
        );
      },
    );
  }
}
