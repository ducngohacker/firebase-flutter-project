import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog(
      {required String title, required FirebaseAuthException exception})
      : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK'
        );
   static String? _message(FirebaseAuthException exception,[PlatformExceptionAlertDialog? platformExceptionAlertDialog]) {

     print(exception.code);
     final Map<String,String> _errors = {
       'wrong-password': 'The password is invalid'
     };
    return _errors[exception.code] ?? exception.message;
  }

}
