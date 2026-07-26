import 'package:flutter/material.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/app_localizations.dart';

class Txt {
  late AppLocalizations _localizations;

  void setLanguage(final BuildContext context) {
    _localizations = AppLocalizations.of(context)!;
  }

  AppLocalizations get get => _localizations;
}
