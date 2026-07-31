import 'package:flutter/material.dart';
import 'package:pulse_monitor/core/navigation/app_nav_commands.dart';
import 'package:pulse_monitor/core/navigation/feature_navigator.dart';
import 'package:pulse_monitor/core/navigation/navigation_command.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';

class BleConnectionNavigator extends FeatureNavigator {
  final Txt txt;

  BleConnectionNavigator(this.txt);

  @override
  void navigate(BuildContext context, NavigationCommand navCommand) {
    if (navCommand is NavProgress) {
      appNavigator.showProgress(context);
    } else {
      appNavigator.popProgress(context);
      if (navCommand is NavMessageDialog) {
        appNavigator.dialogMessage(context, navCommand.payload!);
      } else if (navCommand is NavErrorDialog) {
        appNavigator.dialogError(context, navCommand.payload!);
      } else if (navCommand is NavLimits) {
        appNavigator.limits(context);
      } /*else if (navCommand is NavSearchCriteria) {
        appNavigator.searchCriteria(context);
      } else if (navCommand is NavMovieDetails) {
        _showMovieDetails(context, navCommand.payload!);
      }*/
    }
  }

  // void _showMovieDetails(BuildContext context, Movie movie) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute<MovieDetailsView>(
  //       builder: (BuildContext context) => MovieDetailsView(
  //         txt,
  //         movie.title,
  //         movie.budget.toString(),
  //         movie.revenue.toString(),
  //         _movieDetailsController,
  //       ),
  //     ),
  //   );
  // }
}
