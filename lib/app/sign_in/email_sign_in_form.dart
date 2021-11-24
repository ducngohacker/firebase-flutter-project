import 'dart:io' as Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/app/sign_in/home_page.dart';
import 'package:firebase_database/app/sign_in/validators.dart';
import 'package:firebase_database/common_widgets/form_submit_button.dart';
import 'package:firebase_database/common_widgets/platform_alert_dialog.dart';
import 'package:firebase_database/common_widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_database/services/auth.dart';
import 'package:firebase_database/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  String get _email => _emailController.text;

  String get _password => _passwordController.text;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initSate method called');
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose method called');
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    print(
      "email : ${_emailController.text}, password : ${_passwordController.text}",
    );
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPasswords(
            _emailController.text, _passwordController.text);
      } else {
        await auth.createUserWithEmailAndPasswords(
            _emailController.text, _passwordController.text);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {

      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFromType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;
    return [
      _buildEmailTextField(),
      const SizedBox(
        height: 9.0,
      ),
      _buildPasswordTextField(),
      const SizedBox(
        height: 9.0,
      ),
      FormSubmitButton(
        text: _formType == EmailSignInFormType.signIn
            ? 'Sign in'
            : 'Create an account',
        onPressed: submitEnabled ? _submit : null,
        color: submitEnabled ? Colors.indigo : Colors.grey,
      ),
      TextButton(
        onPressed: _toggleFromType,
        child: Text(
          _formType == EmailSignInFormType.signIn
              ? 'Need an account? Register'
              : 'Have an account? Sign in',
          style: const TextStyle(color: Colors.black),
        ),
      )
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordTextError : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'abc@gmail.com',
        errorText: showErrorText ? widget.invalidEmailTextError : null,
        enabled: _isLoading == false,
      ),
      onChanged: (email) => _updateState(),
      autocorrect: false,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }
}
