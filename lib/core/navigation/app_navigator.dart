import 'package:flutter/material.dart';
import 'package:pulse_monitor/core/get_it.dart';
import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';
import 'package:pulse_monitor/ui_components/dialogs/dialog_factory.dart';
import 'package:pulse_monitor/ui_components/dialogs/e_dialog_msg.dart';
import 'navigation_command.dart';

class AppNavigator {
  final Txt txt;
  final DialogFactory dialogFactory;
  final MovieListNavigator movieListNavigator;
  final TwoButtonNavigator twoButtonNavigator;
  final SearchCriteriaNavigator searchCriteriaNavigator;

  AppNavigator(
    this.txt,
    this.dialogFactory,
    this.movieListNavigator,
    this.twoButtonNavigator,
    this.searchCriteriaNavigator,
  ) {
    movieListNavigator.appNavigator = this;
    twoButtonNavigator.appNavigator = this;
    searchCriteriaNavigator.appNavigator = this;
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

  void twoButtons(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TwoButtonsView(txt, twoButtonNavigator),
      ),
    );
  }

  void searchCriteria(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchCriteriaView(txt: txt, navigator: searchCriteriaNavigator),
      ),
    );
  }

  void movieList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieListView(
          txt: txt,
          appNavigator: this,
          moviesNavigator: movieListNavigator,
          scrollController: getIt<MovieListScrollController>(),
        ),
      ),
    );
  }

  static void throwOnMissingNav(NavigationCommand<dynamic> navCommand) {
    throw UnimplementedError('No navigation implemented for NavCommand: ${navCommand.runtimeType}');
  }
}
