import 'package:firebase_database/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton(
      {required String text, Color? color, Color? textColor, VoidCallback? onPressed,required String assetName})
      : assert(text != null),
        assert(assetName != null),
        super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  assetName,
                  width: 31.0,
                  height: 31.0,
                ),
                Text(
                  text,
                  style:  TextStyle(color: textColor!),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(
                    assetName,
                    width: 31.0,
                    height: 31.0,
                  ),
                ),
              ],
            ),
            color: color!,
            borderRadius: 9.0,
            onPressed: onPressed!,
            height: 51.0
      );
}
