import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../../bloc/questions/questions_bloc.dart';
import '../../../core/utilities/colors.dart';
import '../dialogs/wrong_answer.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final String rightAnswer;
  final bool isHelp;
  final Color? color;

  const AnswerCard({super.key, required this.answer, required this.rightAnswer, this.color, this.isHelp = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.08,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color ?? canvas
          ),
          onPressed: () {
            if(isHelp || answer != rightAnswer) {
              RightAnswerDialog(rightAnswer: rightAnswer);
            } else{
              BlocProvider.of<QuestionsBloc>(context).add(SolvedAnswerEvent(
                difficulty: 0, level: 0, question: 0
              ));
              Helper.toast(context, '♥إجابة صحيحة ');
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