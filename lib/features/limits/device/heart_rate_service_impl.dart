import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:pulse_monitor/features/limits/domain/heart_rate_service.dart';
import 'package:pulse_monitor/features/ble_connection/domain/ble_connection_service_exception.dart';

class HeartRateServiceImpl implements HeartRateService {
  static const EventChannel bleHeartBeatChannel = EventChannel('ble_heart_beat_event_channel');

  HeartRateServiceImpl();

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
