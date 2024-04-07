import 'package:flutter/material.dart';
import 'package:library_treasure_hunt/library/core/utilities/colors.dart';
import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../home/home.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);

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
                  children:List.generate(
                    3, (index) => Padding(
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
                  height: size.height*199/932,
                  width: size.width,
                  child: Card(

                    color: primary,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          'ما هو أسرع حيوان في العالم؟',
                          style: context.getThemeTextStyle().titleLarge,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height*50/930-14,
                ),
                const AnswerCard(answer: 'الاسد'),
                const AnswerCard(answer: 'الفهد'),
                const AnswerCard(answer: 'النمر'),
                const AnswerCard(answer: 'الضبع'),
                SizedBox(
                  height: size.height*50/930,
                ),
                AnswerCard(answer: 'مساعدة',color: primary,isHelp: true,)
              ],
            ),
          ),

        )
    );
  }
}

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key, required this.answer, this.color,this.isHelp=false

  });
  final bool isHelp;
  final Color? color;
  final String answer ;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: SizedBox(
        width: size.width,
        height: size.height * 75/930,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color??canvas
          ),
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home(),
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(isHelp)Image.asset('assets/images/help.png',height: 40,width: 40),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(answer,style: context.getThemeTextStyle().titleLarge,),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
