import 'dart:math';

import 'package:pulse_monitor/features/limits/domain/heart_rate_service.dart';

class HeartRateServiceImpl implements HeartRateService {
  Stream<int>? _heartRateStream;

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
