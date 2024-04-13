import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/questions/questions_bloc.dart';
import '../../../core/global/global.dart';
import '../../screens/level_screen/level_screen.dart';

class LevelCard extends StatelessWidget {
  final int difficulty, level;

  const LevelCard({super.key, required this.difficulty, required this.level});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider<QuestionsBloc>.value(
              value: questionsBloc,
              child: LevelScreen(difficulty: difficulty, level: level,)),
        ),
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: ListTile(
            leading: Image.asset('assets/images/star.png', height: size.height * 0.05,),
            title: Text('المستوى ${levels[level]}'),
            trailing: level == 0 || myAllSolvedQuestions[difficulty][level - 1].length > 9 ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/openLock.png', height: size.height * 0.04,),
                    Text('${myAllSolvedQuestions[difficulty][level].length}/10'),
                  ],
                ):
            Image.asset('assets/images/lock.png', height: size.height * 0.05,),
          ),
        ),
      ),
    );
  }
}
