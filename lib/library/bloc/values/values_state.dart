part of 'values_bloc.dart';

@immutable
abstract class ValuesState {}

class ValuesInitial extends ValuesState {}

class ValuesLoadingState extends ValuesState {}
class ValuesFetchedSuccessfullyState extends ValuesState {}
class ValuesFetchedErrorState extends ValuesState {
  final String error;
  ValuesFetchedErrorState({required this.error});
}
