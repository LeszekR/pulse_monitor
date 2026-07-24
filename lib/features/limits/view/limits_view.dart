import 'package:flutter/material.dart';
import 'package:pulse_monitor/common/ui_localized_texts/app_localizations/app_localizations.dart';

class LimitsView extends StatefulWidget {
  const LimitsView({super.key});

  @override
  LimitsViewState createState() => LimitsViewState();

}

class LimitsViewState extends State<LimitsView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppLocalizations.of(context)!.saved_limits),
        TextField(),
        //
        const SizedBox(height: 4),
        Text(AppLocalizations.of(context)!.upper_limit),
        TextField(),
        //
        const SizedBox(height: 4),
        Text(AppLocalizations.of(context)!.lower_limit),
        TextField(),
        //
        const SizedBox(height: 4),
        ElevatedButton(onPressed: _saveLimits, child: Text(AppLocalizations.of(context)!.button_save_limits)),
        Row(
          children: [
            ElevatedButton(onPressed: _start, child: Text(AppLocalizations.of(context)!.button_start)),
            SizedBox(width: 10),
            ElevatedButton(onPressed: _stop, child: Text(AppLocalizations.of(context)!.button_stop)),
          ],
        ),
      ],
    );
  }

  void _saveLimits() {}

  void _start() {}

  void _stop() {}

}