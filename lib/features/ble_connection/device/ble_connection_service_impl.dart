import 'package:pulse_monitor/features/ble_connection/domain/ble_connection_service.dart';

class BleConnectionServiceImpl implements BleConnectionService {
  @override
  Stream<String> startDiscoveringDevices(){}

  @override
  void stopDiscoveringDevices(){}

  @override
  bool connect(){}

  @override
  bool disconnect(){}
}
