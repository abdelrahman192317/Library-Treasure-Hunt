part of 'connection_bloc.dart';

@immutable
abstract class ConnectivityState {}

class ConnectionInitialState extends ConnectivityState {}

class NoConnectionState extends ConnectivityState {}

class ConnectedState extends ConnectivityState {}