import 'package:flutter/material.dart';
import 'package:pulse_monitor/core/navigation/app_navigator.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';
import 'package:pulse_monitor/features/ble_connection/navigation/ble_connection_navigator.dart';

class BleConnectionView extends StatelessWidget {
  final Txt txt;
  final AppNavigator appNavigator;
  final BleConnectionNavigator bleConnectionNavigator;

  const BleConnectionView({
    super.key,
    required this.txt,
    required this.appNavigator,
    required this.bleConnectionNavigator,
  });

  // button: toggle start discovering devices / stop discovering
  // ListView: available devices
  // device sliver _onTap() => toggle connect / disconnect device

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
