import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/functions.dart';

import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utils/colors.dart';
import '../../data/models/questions_model.dart';
import '../widgets/ads_button.dart';
import '../widgets/answer_card.dart';

class QuestionScreen extends StatelessWidget {
  final int difficulty, level, question;
  final Question q;
  const QuestionScreen(
      {super.key,
      required this.difficulty,
      required this.level,
      required this.question,
      required this.q});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ValuesBloc, ValuesState>(
      builder: (context, state) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                elevation: 0,
                backgroundColor: top,
                actions: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                              state.runtimeType ==
                                      ValuesFetchedSuccessfullyState
                                  ? heartCount! : 5,
                              (index) => Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.01),
                                    child: Image.asset(
                                        'assets/images/heart.png',
                                        height: size.height * 0.03),
                                  )),
                        ]),
                  ),
                ],
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                          child: AutoSizeText(q.question,
                              textAlign: TextAlign.center,
                              style: context
                                  .getThemeTextStyle()
                                  .titleLarge!
                                  .copyWith(color: Colors.black)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    AnswerCard(
                      answer: q.answer_1,
                      rightAnswer: q.rightAnswer,
                      difficulty: difficulty,
                      level: level,
                      question: question,
                      solved: !q.locked,
                    ),
                    AnswerCard(
                      answer: q.answer_2,
                      rightAnswer: q.rightAnswer,
                      difficulty: difficulty,
                      level: level,
                      question: question,
                      solved: !q.locked,
                    ),
                    AnswerCard(
                      answer: q.answer_3,
                      rightAnswer: q.rightAnswer,
                      difficulty: difficulty,
                      level: level,
                      question: question,
                      solved: !q.locked,
                    ),
                    AnswerCard(
                      answer: q.answer_4,
                      rightAnswer: q.rightAnswer,
                      difficulty: difficulty,
                      level: level,
                      question: question,
                      solved: !q.locked,
                    ),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      children: [
                        if(heartCount! < 5)const Expanded(child: AdsButton(answer: 'إضافة قلوب')),
                        SizedBox(width: size.width * 0.01),
                        if (q.locked) Expanded(
                          child: AnswerCard(
                            answer: 'مساعدة',
                            rightAnswer: q.rightAnswer,
                            difficulty: difficulty,
                            level: level,
                            question: question,
                            isHelp: true,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
