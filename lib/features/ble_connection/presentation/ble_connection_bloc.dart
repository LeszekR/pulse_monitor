import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_monitor/core/navigation/app_nav_commands.dart';
import 'package:pulse_monitor/features/ble_connection/domain/ble_connection_service.dart';
import 'package:pulse_monitor/features/ble_connection/domain/ble_connection_service_exception.dart';
import 'package:pulse_monitor/features/ble_connection/presentation/ble_connection_event.dart';
import 'package:pulse_monitor/features/ble_connection/presentation/ble_connection_state.dart';

class BleConnectionBloc extends Bloc<BleConnectionEvent, BleConnectionState> {
  final BleConnectionService bleConnectionService;

  BleConnectionBloc(this.bleConnectionService) : super(BleConnectionState()) {
    on<DiscoverSensorsEvent>(_discoverHeartRateSensors);
    on<ConnectSensorEvent>(_connectHeartRateSensor);
    on<ShowLimitsViewEvent>(_showLimitsView);
  }

  Future<void> _discoverHeartRateSensors(DiscoverSensorsEvent event, Emitter<BleConnectionState> emit) async {
    try {
      await bleConnectionService.startDiscoveringHeartRateSensors();

      final Stream<String> discoveredSensors = bleConnectionService.discoveredSensors!;

      discoveredSensors.listen((device) {
        final Map<String, String> sensors = state.discoveredSensors;
        final List<String> deviceElements = device.split('|');
        final deviceName = deviceElements[2];
        final deviceAddress = deviceElements[3];
        sensors[deviceName] = deviceAddress;
        emit(state.copyWith(discoveredSensors: sensors));
      });
    } on BleConnectionServiceException catch (e) {
      emit(state.copyWith(navCommand: NavErrorDialog(e)));
    }
  }

  Future<void> _connectHeartRateSensor(ConnectSensorEvent event, Emitter<BleConnectionState> emit) async {
    // final String deviceName = await bleConnectionService.startDiscoveringHeartRateSensors();
    // String deviceNameToShow = '';
    // if (deviceName.contains(bleConnectionServiceImpl.platformException)) {
    //   deviceNameToShow = 'Platform exception';
    // } else if (deviceName.contains(bleConnectionServiceImpl.otherException)) {
    //   deviceNameToShow = 'Other exception';
    // }
    // emit(state.copyWith(connectedBleSensor: deviceNameToShow));
  }

  _disconnectHeartRateSensor(DisconnectSensorEvent event, Emitter<BleConnectionState> emit) {}

  _showLimitsView(ShowLimitsViewEvent event, Emitter<BleConnectionState> emit) {} // - nav to LimitsView
}
