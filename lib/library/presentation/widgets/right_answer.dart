import 'package:flutter/material.dart';

import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

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

            Text(rightAnswer, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.green)),
            SizedBox(height: size.height * 0.02,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: SizedBox(
                width: size.width,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('حسناً', style: context.getThemeTextStyle().titleLarge,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}