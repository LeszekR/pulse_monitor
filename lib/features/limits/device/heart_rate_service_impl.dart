import 'dart:math';

import 'package:flutter/services.dart';
import 'package:pulse_monitor/features/limits/domain/heart_rate_service.dart';

class HeartRateServiceImpl implements HeartRateService {
  static const platformException = 'Platform exception';
  static const otherException = 'Other exception';
  static const startScanningOk = 'Started scanning for BLE devices';
  static const startScanningFailed = 'Failed to start scanning for BLE devices';
  static const stopScanningOk = 'Stopped scanning for BLE devices';
  static const stopScanningFailed = 'Failed to stop scanning for BLE devices';

  static const MethodChannel bleConnectionChannel = MethodChannel('ble_connection_channel');
  static const EventChannel bleScanEventChannel = EventChannel('ble_scan_event_channel');
  static const EventChannel bleHeartBeatChannel = EventChannel('ble_heart_beat_event_channel');
  late void Function(String) handleDiscoveryEvent;
  late void Function(int) handleHeartBeatEvent;

  HeartRateServiceImpl();

  @override
  Future<String> startDiscoveringHeartRateSensors() async {
    try {
      await bleConnectionChannel.invokeMethod('startScan');

      bleScanEventChannel
          .receiveBroadcastStream()
          .cast<String>()
          .listen(handleDiscoveryEvent);

      return startScanningOk;
    } on PlatformException catch (e) {
      return 'Start scanning $platformException: ${e.toString()}';
    } catch (e) {
      return 'Start scanning $otherException: ${e.toString()}';
    }
  }

  @override Future<String> stopDiscoveringHeartRateSensors() async {
    try {
      await bleConnectionChannel.invokeMethod('stopScan');
      return stopScanningFailed;
    } on PlatformException catch (e) {
      return 'Stop scanning $platformException: ${e.toString()}';
    } catch (e) {
      return 'Stop scanning $otherException: ${e.toString()}';
    }
  }

  Stream<int>? _heartRateStream;

  @override
  Future<Stream<int>?> startHeartRateStream() async {
    // TODO implement Android/iOS channel
    int mockHeartRate() => 100 + Random().nextInt(50);
    _heartRateStream = Stream.periodic(Duration(seconds: 1), (int count) => mockHeartRate());
    return _heartRateStream;
  }

  @override
  void stopHeartRateStream() async {
    // TODO implement Android/iOS channel
    _heartRateStream = null;
  }
}
