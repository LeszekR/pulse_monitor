import 'dart:math';

import 'package:flutter/services.dart';
import 'package:pulse_monitor/features/limits/domain/heart_rate_service.dart';

class HeartRateServiceImpl implements HeartRateService {
  static MethodChannel bleConnectionChannel = MethodChannel('ble_connection_channel');
  static const platformException = 'Platform exception';
  static const otherException = 'Other exception';
  Stream<int>? _heartRateStream;

  @override
  Future<String> connectHeartRateSensor() async {
    try {
      return await bleConnectionChannel.invokeMethod('discoverDevices');
    } on PlatformException catch (e){
      return '$platformException: ${e.toString()}';
    } catch (e) {
      return '$otherException: ${e.toString()}';
    }
  }

  @override
  void stopHeartRateStream() async {
    // TODO implement Android/iOS channel
    _heartRateStream = null;
  }

  //receiving impulses from the BLE he
  @override
  Future<Stream<int>?> getHeartRateStream() async {
    // TODO implement Android/iOS channel
    int mockHeartRate() => 100 + Random().nextInt(50);
    _heartRateStream = Stream.periodic(Duration(seconds: 1), (int count) => mockHeartRate());
    return _heartRateStream;
  }
}
