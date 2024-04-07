import 'package:flutter/material.dart';
import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../question_screen/question_screen.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Row(
                children: [
                  const Text('20',style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  )),
                  Image.asset('assets/images/key.png',width: 27,height: 27),
                ],
              ),
            ],
            title: const Text(
              'المستوى الاول '
            ),
            centerTitle: true,
          ),
          body: GridView.builder(
            itemCount: 16,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 104/101
              ),
              itemBuilder: (context, index) => const QuestionCard(),
          ),

        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isSolved=false;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const QuestionScreen(),));
      },
      child: Card(
        child: isSolved?Center(child: Text('1',style: context.getThemeTextStyle().headlineLarge!.copyWith(color: Colors.white))):Center(child: Image.asset('assets/images/lock.png',height: size.width*.14,)),
      ),
    );
  }
}
