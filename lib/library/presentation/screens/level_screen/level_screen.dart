import 'package:flutter/material.dart';
import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../../core/global/global.dart';
import '../../widgets/questions/question_card.dart';

class LevelScreen extends StatelessWidget {
  final int difficulty, level;

  const LevelScreen({super.key, required this.difficulty, required this.level});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Text(
                '${myAllSolvedQuestions[difficulty][level].length}',
                style: context.getThemeTextStyle().titleMedium),
              Image.asset('assets/images/key.png',height: size.height * 0.01),
            ],
            title: Text('المستوى ${levels[level]}'),
            centerTitle: true,
          ),
          body: GridView.builder(
            itemCount: myAllQuestions.length,
            padding: EdgeInsets.all(size.height * 0.005),
            itemBuilder: (ctx, index) => QuestionCard(
              difficulty: difficulty, level: level, question: index,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
          ),
        ),
      ),
    );
  }
}
