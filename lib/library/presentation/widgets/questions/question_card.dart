import 'package:flutter/material.dart';
import 'package:library_treasure_hunt/library/core/global/global.dart';
import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../screens/question_screen/question_screen.dart';

class QuestionCard extends StatelessWidget {
  final int difficulty, level, question;
  const QuestionCard({super.key, required this.difficulty, required this.level, required this.question});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            QuestionScreen(difficulty: difficulty,level: level, question: question,)
        ));
      },
      child: Card(
        child: question == 0 || !myAllQuestions[difficulty][level][question - 1].locked ?
          Center(
            child: Text(
              '${question + 1}',
              style: context.getThemeTextStyle().headlineLarge)
          ) :
          Center(child: Image.asset('assets/images/lock.png', height: size.height * 0.1)),
      ),
    );
  }
}