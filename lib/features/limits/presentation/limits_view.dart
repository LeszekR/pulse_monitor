import 'package:flutter/material.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/app_localizations.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_state.dart';
import 'package:pulse_monitor/ui_components/buttons.dart';
import 'package:pulse_monitor/ui_components/text_fields.dart';

class LimitsView extends StatefulWidget {
  const LimitsView({super.key});

  @override
  LimitsViewState createState() => LimitsViewState();
}

class LimitsViewState extends State<LimitsView> {
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
              TextFields.textField(
                outerLabel: AppLocalizations.of(context)!.saved_limits,
                labelPosition: LabelPosition.top,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Buttons.rectangleButton(
                    context: context,
                    text: AppLocalizations.of(context)!.button_save_limits,
                    onPressed: _saveLimits,
                  ),
                ],
              ),
              //
              const SizedBox(height: 30),
              TextFields.textField(
                outerLabel: AppLocalizations.of(context)!.upper_limit,
                labelPosition: LabelPosition.top,
              ),
              //
              const SizedBox(height: 10),
              TextFields.textField(
                outerLabel: AppLocalizations.of(context)!.lower_limit,
                labelPosition: LabelPosition.top,
              ),
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
                    child: Buttons.rectangleButton(
                      context: context,
                      text: AppLocalizations.of(context)!.button_start,
                      onPressed: _start,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Buttons.rectangleButton(
                      context: context,
                      text: AppLocalizations.of(context)!.button_stop,
                      onPressed: _stop,
                    ),
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
