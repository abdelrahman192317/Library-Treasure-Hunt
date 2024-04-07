import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_treasure_hunt/library/presentation/screens/level_screen/level_screen.dart';

import '../../../bloc/questions/questions_bloc.dart';
import '../../../core/global/global.dart';

class LevelCard extends StatelessWidget {

  const LevelCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider<QuestionsBloc>.value(
              value: questionsBloc,
              child: const LevelScreen()),
        ),
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: ListTile(
            leading: Image.asset('assets/images/star.png', height: size.height * 0.05,),
            title: const Text('المستوي '),
            trailing: false ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/openLock.png', height: size.height * 0.04,),
                    const Text('3/10'),
                  ],
                ):
            Image.asset('assets/images/lock.png', height: size.height * 0.05,),
          ),
        ),
      ),
    );
  }
}
