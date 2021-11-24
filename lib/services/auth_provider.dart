import 'package:firebase_database/services/auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({Key? key, required this.auth, required this.child})
      : super(key: key, child: child);
  final AuthBase auth;
  final Widget child;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    print('updateShouldNotify method called');
   return false;
  }

  static AuthBase of(BuildContext context) {
    AuthProvider? provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider!.auth;
  }

}
