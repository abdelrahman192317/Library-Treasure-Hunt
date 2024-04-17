import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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

    on<GetHeartCountEvent>(getHeartCountEvent);

    on<SolvedAnswerEvent>(solvedAnswerEvent);

    on<AddHeartCountEvent>(addHeartCountEvent);
    on<MinusHeartCountEvent>(minusHeartCountEvent);
  }

  FutureOr<void> fetchAllQuestionsEvent(
      FetchAllQuestionsEvent event, Emitter<QuestionsState> emit) async {

    emit(QuestionsLoadingState());
    debugPrint('QuestionsLoadingState');
    try {
      myAllSolvedQuestions = LocalManager.getAllSolvedQuestions();
      myAllQuestions = await QuestionsFirebaseManger.getAllQuestions();
      debugPrint('1');

      emit(QuestionsFetchedSuccessfullyState());
      debugPrint('QuestionsFetchedSuccessfullyState');
    } catch (e) {
      emit(QuestionsErrorState(error: e.toString()));
      debugPrint('QuestionsErrorState');
    }
  }

  FutureOr<void> editNameEvent(
      EditNameEvent event, Emitter<QuestionsState> emit) async {
    emit(NameLoadingState());
    name = event.newName;
    LocalManager.editName(name!);
    emit(NameFetchedSuccessfullyState());
  }
  FutureOr<void> getNameEvent(
      GetNameEvent event, Emitter<QuestionsState> emit) async {
    emit(NameLoadingState());
    name = LocalManager.getName();
    emit(NameFetchedSuccessfullyState());
  }

  FutureOr<void> getHeartCountEvent(
      GetHeartCountEvent event, Emitter<QuestionsState> emit) async {
    emit(HeartCountLoadingState());
    heartCount = LocalManager.getHeartCount();
    emit(HeartCountFetchedSuccessfullyState());
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
    emit(HeartCountLoadingState());
    LocalManager.addHeartCount();
    emit(HeartCountFetchedSuccessfullyState());
  }
  FutureOr<void> minusHeartCountEvent(
      MinusHeartCountEvent event, Emitter<QuestionsState> emit) async {
    emit(HeartCountLoadingState());
    LocalManager.minusHeartCount();
    emit(HeartCountFetchedSuccessfullyState());
  }

}
