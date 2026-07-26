import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_monitor/features/ble_connection/presentation/ble_connection_event.dart';
import 'package:pulse_monitor/features/ble_connection/presentation/ble_connection_state.dart';

class BleConnectionBloc extends Bloc<BleConnectionEvent, BleConnectionState> {
  BleConnectionBloc(super.initialState);

  discoverDevices() {}

  connect() {}

  disconnect() {}

  run() {} // - nav to LimitsView
}