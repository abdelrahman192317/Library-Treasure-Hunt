import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/functions.dart';

import '../../bloc/questions/questions_bloc.dart';
import '../../core/global/global.dart';
import '../screens/edit_question_screen.dart';

class QuestionCard extends StatelessWidget {
  final int difficulty, level, question;
  const QuestionCard({super.key, required this.difficulty, required this.level, required this.question});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider<QuestionsBloc>.value(
                  value: questionsBloc,
                  child: EditQuestion(difficulty: difficulty,level: level, question: question,
                      q: myAllQuestions[difficulty][level][question]),
                )));
          },
          child: Card(
            child: Center(
              child: Text('${question + 1}', style: context.getThemeTextStyle().headlineLarge),
            )
          ),
        );
      },
    );
  }

}