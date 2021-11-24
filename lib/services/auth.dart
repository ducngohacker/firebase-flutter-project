import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseUser {
  FirebaseUser({required this.uid});

  final String uid;
}

abstract class AuthBase {
  Stream<FirebaseUser?> get onAuthStateChanged;

  Future<FirebaseUser?> currentUser();

  Future<FirebaseUser?> signInWithFacebook();

  Future<FirebaseUser?> signInAnonymously();

  Future<FirebaseUser?> signInWithGoogle();

  Future<FirebaseUser?> signInWithEmailAndPasswords(
      String email, String password);

  Future<FirebaseUser?> createUserWithEmailAndPasswords(
      String email, String password);

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser?> currentUser() async {
    final user = await _firebaseAuth.currentUser!;
    return _userFromFirebase(user);
  }

  FirebaseUser? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return FirebaseUser(uid: user.uid);
  }

  @override
  Stream<FirebaseUser?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<FirebaseUser?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user!);
  }

  @override
  Future<FirebaseUser?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<FirebaseUser?> signInWithFacebook() async {
    final loginResult = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);

    if (FacebookAuth.instance.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(loginResult.accessToken!.token));
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<FirebaseUser?> signInWithEmailAndPasswords(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<FirebaseUser?> createUserWithEmailAndPasswords(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    final facebookLogin = FacebookAuth.instance;
    await facebookLogin.logOut();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();

  }
}


