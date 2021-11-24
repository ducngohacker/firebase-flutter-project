import 'package:firebase_database/app/sign_in/email_sign_in_form.dart';
import 'package:firebase_database/services/auth.dart';
import 'package:flutter/material.dart';

class EmailSignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('emailSignInPage method called');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
        elevation: 3.0,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Card(
            child: EmailSignInForm(),
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
