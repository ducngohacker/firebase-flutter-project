import 'package:firebase_database/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton(
      {String? text, Color? color, Color? textColor, VoidCallback? onPressed})
      : super(
            child: Text(
              text!,
              style: TextStyle(color: textColor, fontSize: 15.0),
            ),
            color: color!,
            borderRadius: 9.0,
            onPressed: onPressed!,
            height: 51.0
  );
}
