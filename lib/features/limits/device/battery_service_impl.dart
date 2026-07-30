import 'package:flutter/services.dart';
import 'package:pulse_monitor/features/limits/domain/battery_service.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_view.dart';

class BatteryServiceImpl implements BatteryService {
  static MethodChannel platformBattery = MethodChannel('battery_channel');

  @override
  Future<String> getBatteryLevel() async {
    try {
      final batteryLevel = await platformBattery.invokeMethod('getBatteryLevel');
      return batteryLevel.toString();
    } on PlatformException catch (e) {
      return '${LimitsView.batteryLevelUnknown}\n\n${e.message}.';
    } catch (e) {
      return "${LimitsView.batteryLevelUnknown}\nAndroid error: '${e.toString()}'.";
    }
  }
}
