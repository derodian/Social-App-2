import 'package:flutter/foundation.dart' show immutable;
import 'package:social_app_2/src/common_widgets/alert_dialog_model.dart';
import 'package:social_app_2/src/constants/strings.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog({required String titleOfObjectToDelete})
      : super(
          title: Strings.logout,
          message: Strings.logoutAreYouSure,
          buttons: const {
            Strings.cancel: false,
            Strings.logout: true,
          },
        );
}
