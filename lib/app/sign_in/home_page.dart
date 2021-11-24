import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/common_widgets/platform_alert_dialog.dart';
import 'package:firebase_database/services/auth.dart';
import 'package:firebase_database/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {


  void _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context,listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout ?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(fontSize: 19.0, color: Colors.white),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => _confirmSignOut(context),
            child: const Text(
              'Log out',
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
