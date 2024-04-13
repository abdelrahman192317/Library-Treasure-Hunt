import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/global/global.dart';

import '../../data/repos/questions_firebase.dart';
import '../../data/repos/local.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc() : super(QuestionsInitial()) {
    on<FetchAllQuestionsEvent>(fetchAllQuestionsEvent);

    on<EditNameEvent>(editNameEvent);
    on<GetNameEvent>(getNameEvent);

    on<SolvedAnswerEvent>(solvedAnswerEvent);

    on<AddHeartCountEvent>(addHeartCountEvent);
    on<MinusHeartCountEvent>(minusHeartCountEvent);
  }

  FutureOr<void> fetchAllQuestionsEvent(
      FetchAllQuestionsEvent event, Emitter<QuestionsState> emit) async {

    emit(QuestionsLoadingState());
    try {
      myAllSolvedQuestions = LocalManager.getAllSolvedQuestions();
      myAllQuestions = await QuestionsFirebaseManger.getAllQuestions();

      emit(QuestionsFetchedSuccessfullyState());
    } catch (e) {
      emit(QuestionsErrorState(error: e.toString()));
    }
  }

  FutureOr<void> editNameEvent(
      EditNameEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoadingState());
    name = event.newName;
    LocalManager.editName(name!);
    emit(QuestionsFetchedSuccessfullyState());
  }
  FutureOr<void> getNameEvent(
      GetNameEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoadingState());
    name = LocalManager.getName();
    emit(QuestionsFetchedSuccessfullyState());
  }

  FutureOr<void> solvedAnswerEvent(
      SolvedAnswerEvent event, Emitter<QuestionsState> emit) async {

    emit(QuestionsLoadingState());

    try {

      myAllSolvedQuestions[event.difficulty][event.level][event.question] = event.question.toString();

      LocalManager.updateSolvedQuestions(event.difficulty);

      emit(QuestionsFetchedSuccessfullyState());
    } catch (e) {
      emit(QuestionsErrorState(error: e.toString()));

    }

  }

  FutureOr<void> addHeartCountEvent(
      AddHeartCountEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoadingState());
    LocalManager.addHeartCount();
    emit(QuestionsFetchedSuccessfullyState());
  }
  FutureOr<void> minusHeartCountEvent(
      MinusHeartCountEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoadingState());
    LocalManager.minusHeartCount();
    emit(QuestionsFetchedSuccessfullyState());
  }

}
