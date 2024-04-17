part of 'questions_bloc.dart';

@immutable
abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoadingState extends QuestionsState {}
class QuestionsFetchedSuccessfullyState extends QuestionsState {}
class QuestionsErrorState extends QuestionsState {
  final String error;
  QuestionsErrorState({required this.error});
}

class NameLoadingState extends QuestionsState {}
class NameFetchedSuccessfullyState extends QuestionsState {}

class HeartCountLoadingState extends QuestionsState {}
class HeartCountFetchedSuccessfullyState extends QuestionsState {}
