import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/common_widgets/alert_dialog_model.dart';
import 'package:social_app_2/src/constants/strings.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: const {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
