import 'package:flutter/material.dart';

import '../../core/utils/functions.dart';
import '../../core/utils/colors.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({super.key});


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
            Text('تأكيد الحذف', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.red)),
            SizedBox(height: size.height * 0.02,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('إلغاء', style: context.getThemeTextStyle().titleLarge,),
                  ),
                  SizedBox(width: size.width * 0.01,),
                  TextButton(
                    onPressed: () => Navigator.pop(context, ''),
                    child: Text('حسنــاً', style: context.getThemeTextStyle().titleLarge!.copyWith(color: Colors.red),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}