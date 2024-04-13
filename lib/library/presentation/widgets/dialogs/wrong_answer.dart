import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../../bloc/questions/questions_bloc.dart';



class RightAnswerDialog extends StatelessWidget {
  final String rightAnswer;

  const RightAnswerDialog({super.key, required this.rightAnswer});


  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('الإجابة الصحيحة', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: size.height * 0.02,),

            Text(rightAnswer, style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: size.height * 0.02,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: SizedBox(
                  height: size.height * 0.08,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<QuestionsBloc>(context).add(MinusHeartCountEvent());
                      Navigator.pop(context);
                    },
                    child: Text('حسناً', style: context.getThemeTextStyle().titleLarge,),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}