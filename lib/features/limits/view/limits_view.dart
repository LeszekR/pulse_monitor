import 'package:flutter/material.dart';
import 'package:pulse_monitor/common/ui_localized_texts/app_localizations/app_localizations.dart';
import 'package:pulse_monitor/components/buttons.dart';
import 'package:pulse_monitor/components/text_fields.dart';

enum HeartRateStatus { none, tooLow, ok, tooHigh }

class LimitsView extends StatefulWidget {
  const LimitsView({super.key});

  @override
  LimitsViewState createState() => LimitsViewState();
}

class LimitsViewState extends State<LimitsView> {
  HeartRateStatus status = HeartRateStatus.none;

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
                  border: Border.all(color: Colors.black, width: 2),
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
      HeartRateStatus.none => 70,
      HeartRateStatus.tooLow => 60,
      HeartRateStatus.ok => 70,
      HeartRateStatus.tooHigh => 80,
    };
  }

  void _saveLimits() {}

  void _start() {}

  void _stop() {}
}
