import 'package:firebase_database/app/sign_in/sign_in_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_database/app/sign_in/email_sign_in_page.dart';
import 'package:firebase_database/common_widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_database/common_widgets/sign_in_button.dart';
import 'package:firebase_database/common_widgets/social_sign_in_button.dart';
import 'package:firebase_database/services/auth.dart';
import 'package:firebase_database/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final SignInBloc bloc;
  const SignInPage({Key? key, required this.bloc}) : super(key: key);

  static Widget create(BuildContext context) {
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, _) => SignInPage(
          bloc: bloc,
        ),
      ),
    );
  }

  static const spinkit = SpinKitDualRing(
    color: Colors.indigo,
    size: 35.0,
  );

  void _showSignInError(BuildContext context, FirebaseAuthException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _singInWithFacebook(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      print(auth);
      await auth.signInWithFacebook();
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Time Tracker'),
      ),
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          builder: (context, snapshot) {
            return buildContent(context, snapshot.data);
          }),
    );
  }

  Widget buildContent(BuildContext context, bool? _isLoading) {
    bool? isLoading = _isLoading;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(isLoading ?? false),
              const SizedBox(height: 49.0),
              SocialSignInButton(
                text: 'Sign in with Google',
                color: Colors.white,
                textColor: Colors.black87,
                onPressed: () => _signInWithGoogle(context),
                assetName: 'images/google-logo.png',
              ),
              const SizedBox(height: 9.0),
              SocialSignInButton(
                text: 'Sign in with Facebook',
                color: const Color(0XFF314285),
                textColor: Colors.white,
                onPressed: () => _singInWithFacebook(context),
                assetName: 'images/facebook-logo.png',
              ),
              const SizedBox(height: 9.0),
              SizedBox(
                height: 51.0,
                child: SignInButton(
                  text: 'Sign in with Email',
                  color: const Color(0XFF0C795E),
                  textColor: Colors.white,
                  onPressed: () => _signInWithEmail(context),
                ),
              ),
              const SizedBox(
                height: 9.0,
              ),
              const Text(
                'Or',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 9.0),
              SizedBox(
                height: 51.0,
                child: SignInButton(
                  text: 'Go anonymous',
                  color: const Color(0XFFCAD26E),
                  textColor: Colors.black,
                  onPressed: () => _signInAnonymously(context),
                ),
              ),
              const SizedBox(height: 9.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return spinkit;
    }
    return const Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 33.0, fontWeight: FontWeight.bold),
    );
  }
}
