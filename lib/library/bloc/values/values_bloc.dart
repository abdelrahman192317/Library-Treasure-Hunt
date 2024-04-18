import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/global/global.dart';
import '../../data/repos/local.dart';

part 'values_event.dart';
part 'values_state.dart';

class ValuesBloc extends Bloc<ValuesEvent, ValuesState> {
  ValuesBloc() : super(ValuesInitial()) {
    on<EditNameEvent>(editNameEvent);
    on<GetNameEvent>(getNameEvent);

    on<GetHeartCountEvent>(getHeartCountEvent);

    on<AddHeartCountEvent>(addHeartCountEvent);
    on<MinusHeartCountEvent>(minusHeartCountEvent);
  }

  FutureOr<void> editNameEvent(
      EditNameEvent event, Emitter<ValuesState> emit) async {
    emit(ValuesLoadingState());
    name = event.newName;
    LocalManager.editName(name!);
    emit(ValuesFetchedSuccessfullyState());
  }
  FutureOr<void> getNameEvent(
      GetNameEvent event, Emitter<ValuesState> emit) async {
    emit(ValuesLoadingState());
    name = LocalManager.getName();
    emit(ValuesFetchedSuccessfullyState());
  }

  FutureOr<void> getHeartCountEvent(
      GetHeartCountEvent event, Emitter<ValuesState> emit) async {
    emit(ValuesLoadingState());
    heartCount = LocalManager.getHeartCount();
    emit(ValuesFetchedSuccessfullyState());
  }

  FutureOr<void> addHeartCountEvent(
      AddHeartCountEvent event, Emitter<ValuesState> emit) async {
    emit(ValuesLoadingState());
    LocalManager.addHeartCount();
    emit(ValuesFetchedSuccessfullyState());
  }
  FutureOr<void> minusHeartCountEvent(
      MinusHeartCountEvent event, Emitter<ValuesState> emit) async {
    emit(ValuesLoadingState());
    LocalManager.minusHeartCount();
    emit(ValuesFetchedSuccessfullyState());
  }
}
