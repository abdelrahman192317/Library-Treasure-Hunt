import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../bloc/questions/questions_bloc.dart';
import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import '../screens/question_screen.dart';

class QuestionCard extends StatelessWidget {
  final int difficulty, level, question;
  const QuestionCard({super.key, required this.difficulty, required this.level, required this.question});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if(heartCount! < 1 && myAllQuestions[difficulty][level][question].locked) {
              Helper.toast(context, 'ليس لديك قلوب');
            } else if(question == 0 || !myAllQuestions[difficulty][level][question - 1].locked) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider<ValuesBloc>.value(
                value: valuesBloc,
                  child: QuestionScreen(difficulty: difficulty,level: level, question: question,
                      q: myAllQuestions[difficulty][level][question]),
              )));
            }
          },
          child: Card(
            child: Center(
              child: !myAllQuestions[difficulty][level][question].locked?
                Icon(Icons.check, size: size.height * 0.06, color: Colors.green,)
                : question == 0 || !myAllQuestions[difficulty][level][question - 1].locked ?
                Text('${question + 1}', style: context.getThemeTextStyle().headlineLarge)
                : Image.asset('assets/images/lock.png', height: size.height * 0.08),
            )
          ),
        );
      },
    );
  }
}