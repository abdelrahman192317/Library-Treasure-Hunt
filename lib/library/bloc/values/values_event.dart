part of 'values_bloc.dart';

@immutable
abstract class ValuesEvent {}

class EditNameEvent extends ValuesEvent {
  final String newName;
  EditNameEvent({required this.newName});
}
class GetNameEvent extends ValuesEvent {}

class GetHeartCountEvent extends ValuesEvent {}

class AddHeartCountEvent extends ValuesEvent {}
class MinusHeartCountEvent extends ValuesEvent {}

class EditLastCloseTimeEvent extends ValuesEvent {
  final DateTime lastCloseTime;
  EditLastCloseTimeEvent({required this.lastCloseTime});
}