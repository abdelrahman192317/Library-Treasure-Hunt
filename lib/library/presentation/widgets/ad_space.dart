import 'package:flutter/material.dart';

import '../../core/utilities/colors.dart';

class AdSpaceDialog extends StatelessWidget {
  const AdSpaceDialog({super.key});


  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Dialog(
      elevation: 8,
      backgroundColor: canvas,
      child: SizedBox(
        width: size.width,
        height: size.height * 0.3,
        child: Center(
          child: Text('Advertising Space', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}