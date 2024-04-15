import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/global/global.dart';
import '../../widgets/levels/level_card.dart';

class Levels extends StatelessWidget {
  final int difficulty;

  const Levels({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المستويات'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          itemCount: 10,
          itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
              child: LevelCard(difficulty: difficulty, level: index),
            ),
        ),
      ),
    );
  }
}
