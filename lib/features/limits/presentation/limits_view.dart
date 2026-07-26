import 'package:flutter/material.dart';
import 'package:pulse_monitor/core/navigation/app_navigator.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';
import 'package:pulse_monitor/features/limits/navigation/limits_navigator.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_state.dart';
import 'package:pulse_monitor/ui_components/buttons.dart';
import 'package:pulse_monitor/ui_components/text_fields.dart';

class LimitsView extends StatelessWidget {
  final Txt txt;
  final LimitsNavigator navigator;
  final AppNavigator appNavigator;

  LimitsView({super.key, required this.txt, required this.navigator, required this.appNavigator});

  HeartRateStatus status = HeartRateStatus.tooHigh;

  @override
  Widget build(BuildContext context) {
    double dotSize = _makeDotSize(status);
    double circlePadding = 120 - dotSize;

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Column(
            children: [
              // TODO	add connection status indicator text + color
              const SizedBox(height: 40),
              TextFields.textField(outerLabel: txt.get.saved_limits, labelPosition: LabelPosition.top),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Buttons.rectangleButton(context: context, text: txt.get.button_save_limits, onPressed: _saveLimits),
                ],
              ),
              //
              const SizedBox(height: 30),
              TextFields.textField(outerLabel: txt.get.upper_limit, labelPosition: LabelPosition.top),
              //
              const SizedBox(height: 10),
              TextFields.textField(outerLabel: txt.get.lower_limit, labelPosition: LabelPosition.top),
              //
              const SizedBox(height: 4),
              SizedBox(height: circlePadding),
              Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: _makeColor(status),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1),
                ),
              ),
              SizedBox(height: circlePadding),
              Row(
                children: [
                  Expanded(
                    child: Buttons.rectangleButton(context: context, text: txt.get.button_start, onPressed: _start),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Buttons.rectangleButton(context: context, text: txt.get.button_stop, onPressed: _stop),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
      HeartRateStatus.none => 40,
      HeartRateStatus.tooLow => 40,
      HeartRateStatus.ok => 70,
      HeartRateStatus.tooHigh => 100,
    };
  }

  void _saveLimits() {}

  void _start() {}

  void _stop() {}
}
