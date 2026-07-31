import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_monitor/core/navigation/app_navigator.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';
import 'package:pulse_monitor/features/ble_connection/navigation/ble_connection_navigator.dart';
import 'package:pulse_monitor/features/ble_connection/presentation/ble_connection_bloc.dart';
import 'package:pulse_monitor/features/ble_connection/presentation/ble_connection_event.dart';
import 'package:pulse_monitor/ui_components/button_builder.dart';

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
    final BleConnectionBloc bloc = context.read<BleConnectionBloc>();

    // TODO add scroll controller and save the offset in state

    return SafeArea(
      child: BlocBuilder(
        builder: (BuildContext context, Object? state) {
          return Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(height: 20),
                ButtonBuilder().text(txt.get.button_nav_limits).onTap(() => _showLimits(bloc)).build(),
                SizedBox(height: 20),
                ButtonBuilder().text(txt.get.button_discover_sensors).onTap(() => _discoverSensors(bloc)).build(),
                ListView.builder(
                    itemBuilder: (BuildContext context, int index) {  },
                    // TU PRZERWAŁEM - finish building the view
                    child: Column
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  NullableIndexedWidgetBuilder _deviceSliverBuilder

  void _showLimits(BleConnectionBloc bloc) {
    bloc.add(ShowLimitsViewEvent());
  }

  void _discoverSensors(BleConnectionBloc bloc) {
    bloc.add(DiscoverSensorsEvent());
  }
}
