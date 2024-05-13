import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/utils/functions.dart';
import '../../presentation/widgets/right_answer.dart';

import '../../bloc/questions/questions_bloc.dart';
import '../../bloc/values/values_bloc.dart';
import '../../core/global/global.dart';
import '../../core/utils/colors.dart';

class AnswerCard extends StatefulWidget {
  final int difficulty, level, question;
  final String answer, rightAnswer;
  final bool isHelp, solved;

  const AnswerCard({
    super.key,
    required this.difficulty,
    required this.level,
    required this.question,

    required this.answer,
    required this.rightAnswer,

    this.isHelp = false,

    this.solved = false,
  });

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {

  bool _solved = false;
  bool _wrong = false;

  @override
  void initState() {
    _solved = widget.solved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.08,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: _wrong
                  ? Colors.redAccent
                  : (_solved && widget.answer == widget.rightAnswer)
                      ? canvas
                      : widget.isHelp
                          ? background
                          : Colors.white),
          onPressed: _solved
              ? () {}
              : (){
            if(heartCount! < 1) {
              Helper.toast(context, 'ليس لديك قلوب');
            } else if (widget.isHelp){
              questionsBloc.add(SolvedAnswerEvent(difficulty: widget.difficulty, level: widget.level, question: widget.question));
              player.setAudioSource(AudioSource.asset('assets/audio/click.mp3')).then((value) => player.play());

              showDialog(context: context, builder: (c) => RightAnswerDialog(
                  rightAnswer: widget.rightAnswer)).then((value) {
                valuesBloc.add(MinusHeartCountEvent());
                Navigator.pop(context, '');
              });
            }
            else if (widget.answer != widget.rightAnswer) {
              valuesBloc.add(MinusHeartCountEvent());
              setState(() => _wrong = true);

              player.setAudioSource(AudioSource.asset('assets/audio/mistake.wav')).then((value) => player.play());
              showDialog(context: context, builder: (c) => RightAnswerDialog(rightAnswer: widget.rightAnswer));
            }
            else {
              questionsBloc.add(SolvedAnswerEvent(difficulty: widget.difficulty, level: widget.level, question: widget.question));
              setState(() => _solved = true);

              player.setAudioSource(AudioSource.asset('assets/audio/correct.mp3')).then((value) => player.play());

              Helper.toast(context, 'إجابــة صحيحـــة ♥');
              Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context, ''));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isHelp) Image.asset('assets/images/help.png', height: size.height * 0.04),
              Padding(
                  padding: EdgeInsets.only(right: size.height * 0.02),
                  child: Text(widget.answer,
                      style: context.getThemeTextStyle().titleLarge!.copyWith(
                          color: widget.isHelp ? null : Colors.black))),
            ],
          ),
        ),
      ),
    );
  }
}
