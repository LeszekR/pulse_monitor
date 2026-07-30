import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_monitor/core/navigation/app_navigator.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';
import 'package:pulse_monitor/features/limits/navigation/limits_navigator.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_bloc.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_event.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_state.dart';
import 'package:pulse_monitor/ui_components/buttons.dart';
import 'package:pulse_monitor/ui_components/text_fields.dart';

class LimitsView extends StatelessWidget {
  static const batteryLevelUnknown = 'battery level unknown';

  final Txt txt;
  final LimitsNavigator navigator;
  final AppNavigator appNavigator;
  final TextEditingController _lowerLimitController = TextEditingController();
  final TextEditingController _upperLimitController = TextEditingController();

  LimitsView({super.key, required this.txt, required this.navigator, required this.appNavigator});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LimitsBloc>();

    return BlocConsumer<LimitsBloc, LimitsState>(
      listenWhen: (previous, current) => previous.navCommand != current.navCommand,
      listener: (context, state) => navigator.go(context, state.navCommand),

      // buildWhen: (previous, current) =>
      //     previous.heartRateStatus != current.heartRateStatus || previous.batteryLevel != current.batteryLevel,
      builder: (context, state) {
        _lowerLimitController.text = state.lowerLimit == null ? '' : state.lowerLimit!.toString();
        _upperLimitController.text = state.upperLimit == null ? '' : state.upperLimit!.toString();

        double dotSize = _makeDotSize(state.heartRateStatus);
        double circlePadding = 90 - dotSize / 2;

        return SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              child: Column(
                children: [
                  // TODO	add connection status indicator text + color
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(child: SizedBox()),
                      SizedBox(
                        width: 200,
                        height: 27,
                        child: InkWell(
                          onTap: () => _checkBatteryLevel(bloc),
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: _getBatteryColor(state.batteryLevel)),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Align(
                                alignment: AlignmentGeometry.center,
                                child: Text(_getBatteryLevelString(state.batteryLevel)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () => _connectHeartRateSensor(bloc),
                        child: SizedBox(
                          width: 200,
                          height: 27,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: _getSensorColor(state.connectedBleSensor)),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Align(
                                alignment: AlignmentGeometry.center,
                                child: Text(state.connectedBleSensor ?? txt.get.connect_heart_rate_monitor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ),
                  const SizedBox(height: 20),
                  TextFields.textField(outerLabel: txt.get.saved_limits, labelPosition: LabelPosition.top),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Buttons.rectangleButton(
                        context: context,
                        text: txt.get.button_save_limits,
                        onPressed: () => _saveLimits(bloc),
                      ),
                    ],
                  ),
                  //
                  const SizedBox(height: 30),
                  TextFields.textField(
                    outerLabel: txt.get.upper_limit,
                    labelPosition: LabelPosition.top,
                    controller: _lowerLimitController,
                    onChanged: (String value) => _setLowerLimit(bloc, value),
                  ),
                  //
                  const SizedBox(height: 10),
                  TextFields.textField(
                    outerLabel: txt.get.lower_limit,
                    labelPosition: LabelPosition.top,
                    controller: _upperLimitController,
                    onChanged: (String value) => _setUpperLimit(bloc, value),
                  ),
                  //
                  const SizedBox(height: 4),
                  SizedBox(height: circlePadding),
                  Container(
                    width: dotSize,
                    height: dotSize,
                    decoration: BoxDecoration(
                      color: _makeColor(state.heartRateStatus),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                  SizedBox(height: circlePadding),
                  Row(
                    children: [
                      Expanded(
                        child: Buttons.rectangleButton(
                          context: context,
                          text: txt.get.button_start,
                          onPressed: () => _start(bloc),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Buttons.rectangleButton(
                          context: context,
                          text: txt.get.button_stop,
                          onPressed: () => _stop(bloc),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _makeColor(HeartRateStatus level) {
    return switch (level) {
      HeartRateStatus.none => Colors.white,
      HeartRateStatus.tooLow => Colors.blue,
      HeartRateStatus.ok => Colors.green,
      HeartRateStatus.tooHigh => Colors.red,
    };
  }

  double _makeDotSize(HeartRateStatus level) {
    return switch (level) {
      HeartRateStatus.none => 70,
      HeartRateStatus.tooLow => 70,
      HeartRateStatus.ok => 90,
      HeartRateStatus.tooHigh => 110,
    };
  }

  void _checkBatteryLevel(LimitsBloc bloc) {
    bloc.add(CheckBatteryLevelEvent());
  }

  String _getBatteryLevelString(String? batteryLevel) {
    if (batteryLevel == null) {
      return txt.get.battery_level_unknown;
    }
    try {
      var level = int.parse(batteryLevel);
      return '${txt.get.battery}: $level%';
    } catch (e) {
      return '${txt.get.error}: ${txt.get.battery_level_unknown}';
    }
  }

  Color _getBatteryColor(String? batteryLevel) {
    if (batteryLevel == null) {
      return Colors.white;
    } else if (batteryLevel == batteryLevelUnknown) {
      return Colors.white;
    } else {
      int level = int.parse(batteryLevel);
      return switch (level) {
        >= 60 => Colors.white,
        <= 30 => Colors.pink,
        _ => Colors.yellow,
      };
    }
  }

  void _connectHeartRateSensor(LimitsBloc bloc) {
    bloc.add(ConnectSensorEvent());
  }

  Color _getSensorColor(String? sensorDeviceName) {
    if (sensorDeviceName == null) {
      return Color.fromRGBO(248, 241, 156, 0.7647058823529411);
    }      else if (sensorDeviceName.contains('xception')) {
      return Color.fromRGBO(236, 71, 71, 0.30980392156862746);
    } else {
      return Colors.white;
    }
  }

  void _saveLimits(LimitsBloc bloc) {
    bloc.add(SaveLimitsEvent());
  }

  void _start(LimitsBloc bloc) {
    bloc.add(StartMonitoringEvent());
  }

  void _stop(LimitsBloc bloc) {
    bloc.add(StopMonitoringEvent());
  }

  void _setLowerLimit(LimitsBloc bloc, String limit) {
    bloc.add(SetLowerLimitEvent(limit));
  }

  void _setUpperLimit(LimitsBloc bloc, String limit) {
    bloc.add(SetUpperLimitEvent(limit));
  }
}
