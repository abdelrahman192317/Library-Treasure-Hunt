import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/functions.dart';

import '../../bloc/questions/questions_bloc.dart';
import '../../core/global/global.dart';
import '../screens/edit_question_screen.dart';
import 'confirm_delete.dart';

class QuestionCard extends StatelessWidget {
  final int diff, level, question;
  const QuestionCard({super.key, required this.diff, required this.level, required this.question});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        return InkWell(
          onLongPress: (){
            if(question == myAllQuestions[diff][level].length - 1){
              showDialog(context: context, builder: (c) => const ConfirmDeleteDialog())
                  .then((value) => value == null? null : deleteQuestion(context));
            }
          },
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider<QuestionsBloc>.value(
                  value: questionsBloc,
                  child: EditQuestion(difficulty: diff,level: level, question: question,
                      q: myAllQuestions[diff][level][question]),
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
  
  Future<void> deleteQuestion(BuildContext context) async{
    try {

      await FirebaseFirestore.instance.collection(difficulty[diff]).doc('level $level')
          .collection('Questions').doc('$question').delete();

      questionsBloc.add(FetchAllQuestionsEvent());

      Future.delayed(const Duration(seconds: 5));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Question Deleted successfully'), duration: Duration(seconds: 1),),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  
}