part of 'questions_bloc.dart';

@immutable
abstract class QuestionsEvent {}

class FetchAllQuestionsEvent extends QuestionsEvent {}

class SolvedAnswerEvent extends QuestionsEvent {
  final int difficulty, level, question;
  SolvedAnswerEvent({required this.difficulty, required this.level, required this.question});
}