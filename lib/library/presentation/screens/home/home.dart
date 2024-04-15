import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_treasure_hunt/library/core/global/global.dart';
import 'package:library_treasure_hunt/library/core/utilities/functions.dart';

import '../../../bloc/questions/questions_bloc.dart';
import '../add_question/add_question.dart';
import '../levels/levels.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.all(size.height * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.05),
                  Row(
                    children: [
                      Image.asset('assets/images/welcome.png',width: size.width * 0.6),
                      const Spacer(),
                      ...List.generate( state.runtimeType == QuestionsFetchedSuccessfullyState?
                        heartCount! : 3, (index) => Padding(
                          padding:  EdgeInsets.only(right: size.width * 0.01),
                          child: Image.asset('assets/images/heart.png', height: size.height * 0.03),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  Text('برجاء إختيار مستوي الصعوبة',
                    style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: size.height * 0.02),

                  SizedBox(
                    width: size.width,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => BlocProvider<QuestionsBloc>.value(
                        value: questionsBloc,
                            child: const Levels(difficulty: 0),
                          ))),
                      child:  Text('سهل',style: context.getThemeTextStyle().titleLarge),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).canvasColor,
                      ),
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => BlocProvider<QuestionsBloc>.value(
                        value: questionsBloc,
                        child: const Levels(difficulty: 1),
                      ))),
                      child:  Text('متوسط',style: context.getThemeTextStyle().titleLarge),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => BlocProvider<QuestionsBloc>.value(
                        value: questionsBloc,
                        child: const Levels(difficulty: 2),
                      ))),
                      child:  Text('صعب',style: context.getThemeTextStyle().titleLarge),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),

                  SizedBox(
                    width: size.width,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).focusColor,
                      ),
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const AddQuestion(),
                      )),
                      child:  Text('إضافة سؤال',style: context.getThemeTextStyle().titleLarge),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
