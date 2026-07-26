import 'package:pulse_monitor/ui_components/dialogs/e_dialog_msg.dart';

import 'navigation_command.dart';

final class NavProgress extends NavigationCommand {
  NavProgress() : super();
}

final class NavMessageDialog extends NavigationCommand<EDialogMsg> {
  NavMessageDialog(super.dialogParams);
}

final class NavErrorDialog extends NavigationCommand<Exception> {
  NavErrorDialog(super.e);
}

final class NavLimits extends NavigationCommand {}

final class NavBleConnection extends NavigationCommand {}
