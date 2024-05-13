import 'package:flutter/material.dart';

import '../../core/utils/functions.dart';
import '../../core/utils/colors.dart';

class RightAnswerDialog extends StatelessWidget {
  final String rightAnswer;

  const RightAnswerDialog({super.key, required this.rightAnswer});


  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Dialog(
      elevation: 8,
      backgroundColor: canvas,
      child: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('الإجابــة الصحيحـــة', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
            SizedBox(height: size.height * 0.02,),

            Text(rightAnswer,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white)),
            SizedBox(height: size.height * 0.02,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: SizedBox(
                width: size.width,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('حسنــاً', style: context.getThemeTextStyle().titleLarge,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}