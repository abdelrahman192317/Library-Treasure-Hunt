part of 'questions_bloc.dart';

@immutable
abstract class QuestionsEvent {}

class FetchAllQuestionsEvent extends QuestionsEvent {}

class CheckAnswerEvent extends QuestionsEvent {
  final String answer;
  CheckAnswerEvent({required this.answer});
}