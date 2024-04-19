import 'package:flutter/material.dart';

import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../bloc/questions/questions_bloc.dart';
import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utilities/colors.dart';
import 'right_answer.dart';

class AnswerCard extends StatelessWidget {
  final int difficulty, level, question;
  final String answer, rightAnswer;
  final bool isHelp;

  const AnswerCard({super.key, required this.answer, required this.rightAnswer, this.isHelp = false,
    required this.difficulty, required this.level, required this.question});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.08,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: isHelp? primary : canvas),
          onPressed: () {
            if(isHelp || answer != rightAnswer) {
              valuesBloc.add(MinusHeartCountEvent());
              showDialog(context: context, builder: (c) => RightAnswerDialog(rightAnswer: rightAnswer)
                ).then((value) => Navigator.pop(context));
            } else{
              questionsBloc.add(SolvedAnswerEvent(
                difficulty: difficulty, level: level, question: question
              ));
              Helper.toast(context, 'إجابة صحيحة ♥');
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(isHelp)
                Image.asset('assets/images/help.png',height: size.height * 0.04),
              Padding(
                padding: EdgeInsets.only(right: size.height * 0.02),
                child: Text(answer,style: context.getThemeTextStyle().titleLarge,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}