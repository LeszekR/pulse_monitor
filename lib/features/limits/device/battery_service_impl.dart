import 'package:flutter/services.dart';
import 'package:pulse_monitor/features/limits/domain/battery_service.dart';

class BatteryServiceImpl implements BatteryService {
  static MethodChannel platformBattery = MethodChannel('samples.flutter.dev/battery');
  static String batteryLevelUnknown = 'Battery level unknown.\n\n';

  @override
  Future<String> getBatteryLevel() async {
    try {
      final batteryLevel = await platformBattery.invokeMethod('getBatteryLevel');
      return batteryLevel.toString();
    } on PlatformException catch (e) {
      return "$batteryLevelUnknown: '${e.message}'.";
    } catch (e) {
      return "$batteryLevelUnknown Android error: '${e.toString()}'.";
    }
  }
}
