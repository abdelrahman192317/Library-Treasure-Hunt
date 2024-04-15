part of 'questions_bloc.dart';

@immutable
abstract class QuestionsEvent {}

class FetchAllQuestionsEvent extends QuestionsEvent {}

class EditNameEvent extends QuestionsEvent {
  final String newName;
  EditNameEvent({required this.newName});
}
class GetNameEvent extends QuestionsEvent {}

class GetHeartCountEvent extends QuestionsEvent {}

class SolvedAnswerEvent extends QuestionsEvent {
  final int difficulty, level, question;
  SolvedAnswerEvent({required this.difficulty, required this.level, required this.question});
}

class AddHeartCountEvent extends QuestionsEvent {}
class MinusHeartCountEvent extends QuestionsEvent {}