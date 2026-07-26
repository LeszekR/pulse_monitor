import 'package:flutter/material.dart';
import 'package:pulse_monitor/core/config/app_colors.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';
import 'package:pulse_monitor/features/ble_connection/navigation/ble_connection_navigator.dart';
import 'package:pulse_monitor/features/ble_connection/presentation/ble_connection_view.dart';
import 'package:pulse_monitor/features/limits/navigation/limits_navigator.dart';
import 'package:pulse_monitor/features/limits/presentation/limits_view.dart';
import 'package:pulse_monitor/ui_components/dialogs/dialog_factory.dart';
import 'package:pulse_monitor/ui_components/dialogs/e_dialog_msg.dart';

import 'navigation_command.dart';

class AppNavigator {
  final Txt txt;
  final DialogFactory dialogFactory;
  final BleConnectionNavigator bleConnectionNavigator;
  final LimitsNavigator limitsNavigator;

  AppNavigator(this.txt, this.dialogFactory, this.bleConnectionNavigator, this.limitsNavigator) {
    bleConnectionNavigator.appNavigator = this;
    limitsNavigator.appNavigator = this;
  }

  bool _isProgressVisible = false;

  void showProgress(BuildContext context) {
    if (_isProgressVisible) return;
    _isProgressVisible = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.dialogBarrier(),
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
  }

  void popProgress(BuildContext context) {
    if (!_isProgressVisible) return;
    if (!Navigator.of(context).canPop()) return;
    _isProgressVisible = false;
    Navigator.of(context).pop();
  }

  void dialogMessage(BuildContext context, EDialogMsg dialogType) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.dialogBarrier(),
      builder: (context) => dialogFactory.message(dialogType),
    );
  }

  void dialogError(BuildContext context, Exception e) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.dialogBarrier(),
      builder: (context) => dialogFactory.error(e),
    );
  }

  void limits(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LimitsView(txt: txt, appNavigator: this, navigator: limitsNavigator),
      ),
    );
  }

  void bleConnection(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            BleConnectionView(txt: txt, appNavigator: this, bleConnectionNavigator: bleConnectionNavigator),
      ),
    );
  }

  static void throwOnMissingNav(NavigationCommand<dynamic> navCommand) {
    throw UnimplementedError('No navigation implemented for NavCommand: ${navCommand.runtimeType}');
  }
}
