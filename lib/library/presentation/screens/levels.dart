import 'package:flutter/material.dart';
import '../../core/utils/colors.dart';
import '../widgets/level_card.dart';

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
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'المستويات',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: top,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [top, bottom],
            ),
          ),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            itemCount: 10,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
              child: LevelCard(difficulty: difficulty, level: index),
            ),
          ),
        ),
      ),
    );
  }
}
