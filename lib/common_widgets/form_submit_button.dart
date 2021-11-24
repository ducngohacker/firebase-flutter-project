import 'package:firebase_database/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({required String text, required VoidCallback? onPressed,required Color color})
      : super(
          child:  Text(
            text,
            style: const TextStyle(color: Colors.white,fontSize: 21.0),
          ),
          color: color,
          onPressed: onPressed,
          height: 45.0,
          borderRadius: 5.0
        );
}
