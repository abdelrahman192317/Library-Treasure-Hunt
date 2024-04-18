import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../core/global/global.dart';

import '../../data/repos/questions_firebase.dart';
import '../../data/repos/local.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc() : super(QuestionsInitial()) {

    on<FetchAllQuestionsEvent>(fetchAllQuestionsEvent);
    on<SolvedAnswerEvent>(solvedAnswerEvent);
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

  FutureOr<void> solvedAnswerEvent(
      SolvedAnswerEvent event, Emitter<QuestionsState> emit) async {

    emit(QuestionsLoadingState());
    try {
      myAllSolvedQuestions[event.difficulty][event.level][event.question.toString()] = '${event.question}';
      myAllQuestions[event.difficulty][event.level][event.question].locked = false;
      LocalManager.updateSolvedQuestions(event.difficulty);

      emit(QuestionsFetchedSuccessfullyState());
    } catch (e) {
      emit(QuestionsErrorState(error: e.toString()));
    }
  }

}
