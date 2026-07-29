import 'package:pulse_monitor/core/ui_localized_texts/app_localizations/txt.dart';
import 'package:pulse_monitor/features/ble_connection/domain/ble_connection_exception.dart';

import 'dialog_params.dart';
import 'e_dialog_msg.dart';
import 'message_dialog.dart';

class DialogFactory {
  final Txt txt;

  const DialogFactory(this.txt);

  MessageDialog message(EDialogMsg type) {
    DialogParams params;
    switch (type) {
      case EDialogMsg.blePermissionMissing:
        params = DialogParamsOk(txt.get.ble_permission_missing);
      case EDialogMsg.bleDisconnected:
        params = DialogParamsOk(txt.get.ble_disconnected);
      case EDialogMsg.failedToStopMonitoring:
        params = DialogParamsOk(txt.get.failed_to_stop_monitoring);
      case EDialogMsg.limitsNotSet:
        params = DialogParamsOk(txt.get.limits_not_set);
    }
    return MessageDialog(txt, params);
  }

  MessageDialog error(Exception e) {
    String? text;
    if (e is BleConnectionFailedException) {
      text = '${txt.get.error_ble_connection_failed}\n\n${e.toString()}';
    } /*else if (e is MovieListOtherException) {
      text = '${txt.get.error_get_searched_movies}\n\n${e.toString()}';
    } else if (e is MovieDetailsHttpException) {
      text = '${txt.get.error_get_movie}${txt.get.error_http}${e.toString()}';
    } else if (e is MovieDetailsOtherException) {
      text = '${txt.get.error_get_movie}\n\n${e.toString()}';
    }*/ else {
      text = 'Error: ${e.toString()}';
      // throw UnimplementedError('Not implemented error dialog case for: ${e.runtimeType}');
    }
    return MessageDialog(txt, DialogParamsOk(text, txt.get.dialog_title_error));
  }
}

