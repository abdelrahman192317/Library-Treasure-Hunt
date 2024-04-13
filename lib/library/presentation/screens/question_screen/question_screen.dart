import 'package:flutter/material.dart';
import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../../core/global/global.dart';
import '../../../core/utilities/colors.dart';
import '../../widgets/answers/answer_card.dart';


class QuestionScreen extends StatelessWidget {
  final int difficulty, level, question;
  const QuestionScreen({super.key, required this.difficulty, required this.level, required this.question});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding:  const EdgeInsets.all(8.0),
                child: Row(
                  children: List.generate(
                    heartCount!, (index) => Padding(
                    padding:  EdgeInsets.only(right:size.width * 0.01),
                    child: Image.asset('assets/images/heart.png', height: size.height * 0.03),
                  ),
                  )
                ),
              ),
            ],
          ),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width*25/430),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width,
                  child: Card(
                    //color: primary,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          myAllQuestions[difficulty][level][question].question,
                          style: context.getThemeTextStyle().titleLarge,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height* 0.05),

                AnswerCard(
                  answer: myAllQuestions[difficulty][level][question].answer_1,
                  rightAnswer: myAllQuestions[difficulty][level][question].rightAnswer,
                ),
                AnswerCard(
                  answer: myAllQuestions[difficulty][level][question].answer_2,
                  rightAnswer: myAllQuestions[difficulty][level][question].rightAnswer,
                ),
                AnswerCard(
                  answer: myAllQuestions[difficulty][level][question].answer_3,
                  rightAnswer: myAllQuestions[difficulty][level][question].rightAnswer,
                ),
                AnswerCard(
                  answer: myAllQuestions[difficulty][level][question].answer_4,
                  rightAnswer: myAllQuestions[difficulty][level][question].rightAnswer,
                ),

                SizedBox(height: size.height * 0.05),

                AnswerCard(answer: 'مساعدة', rightAnswer: '', color: primary, isHelp: true),
              ],
            ),
          ),

        )
    );
  }
}
