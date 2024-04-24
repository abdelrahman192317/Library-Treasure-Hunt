import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utilities/colors.dart';
import '../../data/models/questions_model.dart';
import '../widgets/ad_space.dart';
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
                backgroundColor: top,
                actions: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(state.runtimeType == ValuesFetchedSuccessfullyState && heartCount! < 3)
                          IconButton(
                            onPressed: (){
                              player.setAudioSource(AudioSource.asset('assets/audio/click.mp3'))
                                  .then((value) => player.play());
                              showDialog(context: context,
                                  barrierColor: shadow,
                                  builder: (ct) => const AdSpaceDialog())
                                  .then((value) => valuesBloc.add(AddHeartCountEvent()));
                            },
                            icon: Icon(Icons.add, color: primary),
                          ),
                        ...List.generate( state.runtimeType == ValuesFetchedSuccessfullyState?
                        heartCount! : 3, (index) => Padding(
                          padding:  EdgeInsets.only(left:size.width * 0.01),
                          child: Image.asset('assets/images/heart.png', height: size.height * 0.03),
                        )),
                      ]
                    ),
                  ),
                ],
              ),
              body: Container(
                padding:  EdgeInsets.symmetric(horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [top, bottom],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                      width: size.width,
                      child: Card(
                        color: Colors.white,
                        child: Center(
                          child: FittedBox(
                            child: Text(q.question,
                                style: context.getThemeTextStyle().titleLarge!.copyWith(color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height* 0.05),

                    AnswerCard(answer: q.answer_1, rightAnswer: q.rightAnswer,
                    difficulty: difficulty, level: level, question: question, solved: !q.locked),
                    AnswerCard(answer: q.answer_2, rightAnswer: q.rightAnswer,
                      difficulty: difficulty, level: level, question: question, solved: !q.locked),
                    AnswerCard(answer: q.answer_3, rightAnswer: q.rightAnswer,
                      difficulty: difficulty, level: level, question: question, solved: !q.locked),
                    AnswerCard(answer: q.answer_4, rightAnswer: q.rightAnswer,
                      difficulty: difficulty, level: level, question: question, solved: !q.locked),

                    SizedBox(height: size.height * 0.05),

                    if(q.locked)
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
