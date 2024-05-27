part of 'values_bloc.dart';

@immutable
abstract class ValuesEvent {}

class EditNameEvent extends ValuesEvent {
  final String newName;
  EditNameEvent({required this.newName});
}
class GetNameEvent extends ValuesEvent {}

class AddHeartCountEvent extends ValuesEvent {}
class MinusHeartCountEvent extends ValuesEvent {}

class GetLastCloseTimeEvent extends ValuesEvent {}