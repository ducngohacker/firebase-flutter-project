import 'package:firebase_database/app/sign_in/home_page.dart';
import 'package:firebase_database/app/sign_in/sign_in_page.dart';
import 'package:firebase_database/services/auth.dart';
import 'package:firebase_database/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context,listen: false);
    return StreamBuilder<FirebaseUser?>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser? user = snapshot.data;
          print(user);
          if (user == null) {
            return SignInPage.create(context);
          }
          return HomePage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
