import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectivityState> {
  ConnectionBloc() : super(ConnectionInitialState()) {
    on<InitialConnectionEvent>(initialConnectionEvent);
  }

  FutureOr<void> initialConnectionEvent(
      ConnectionEvent event, Emitter<ConnectivityState> emit) async {

    //in first check the internet port and connection
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      bool isDeviceConnected = await InternetConnectionChecker().hasConnection;
      isDeviceConnected ? emit(ConnectedState()) : emit(NoConnectionState());
    }else {
      emit(NoConnectionState());
    }

    //then adding listen on connection
    Connectivity().onConnectivityChanged.listen(_handleConnectivityChange);
  }

  void _handleConnectivityChange(ConnectivityResult result) async {
    if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      bool isDeviceConnected = await InternetConnectionChecker().hasConnection;
      isDeviceConnected ? emit(ConnectedState()) : emit(NoConnectionState());
    }else {
      emit(NoConnectionState());
    }
  }
}
