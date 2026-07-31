import 'package:flutter/services.dart';
import 'package:pulse_monitor/features/ble_connection/domain/ble_connection_service.dart';
import 'package:pulse_monitor/features/ble_connection/domain/ble_connection_service_exception.dart';

class BleConnectionServiceImpl implements BleConnectionService {
  static const platformException = 'Platform exception';
  static const otherException = 'Other exception';
  static const startScanningOk = 'Started scanning for BLE devices';
  static const startScanningFailed = 'Failed to start scanning for BLE devices';
  static const stopScanningOk = 'Stopped scanning for BLE devices';
  static const stopScanningFailed = 'Failed to stop scanning for BLE devices';

  static const MethodChannel bleConnectionChannel = MethodChannel('ble_connection_channel');
  static const EventChannel bleScanEventChannel = EventChannel('ble_scan_event_channel');

  @override
  Stream<String>? discoveredSensors;

  @override
  Future<void> startDiscoveringHeartRateSensors() async {
    try {
      await bleConnectionChannel.invokeMethod('startScan');

      discoveredSensors = bleScanEventChannel.receiveBroadcastStream().cast<String>();
    } on PlatformException catch (e) {
      throw BleConnectionServiceException('Start scanning $platformException: ${e.toString()}');
    } catch (e) {
      throw BleConnectionServiceException('Start scanning $otherException: ${e.toString()}');
    }
  }

  @override
  Future<String> stopDiscoveringHeartRateSensors() async {
    try {
      await bleConnectionChannel.invokeMethod('stopScan');
      return stopScanningFailed;
    } on PlatformException catch (e) {
      return 'Stop scanning $platformException: ${e.toString()}';
    } catch (e) {
      return 'Stop scanning $otherException: ${e.toString()}';
    }
  }

  @override
  bool connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  bool disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }
}
