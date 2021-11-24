import 'dart:io';

import 'package:firebase_database/common_widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog(

      {required this.title,
      required this.content,
        this.cancelActionText,
        required this.defaultActionText})
      : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  final String title;
  final String? content;
  final String? cancelActionText;
  final String defaultActionText;

  Future<bool> show(BuildContext context) async {
    print(this);
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: context,
            builder: (context) => this,
          )
        : await showDialog(
            context: context,
            builder: (context) => this,
          );

  }
  @override
  Widget buildCupertinoWidget(BuildContext context) {
    // TODO: implement buildCupertinoWidget
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content!),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    // TODO: implement buildMaterialWidget
    print('buildMaterialWidget method called');
    return AlertDialog(
      title: Text(title),
      content: Text(content!),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    print('buildActions method called');
    final actions = <Widget>[];
    if(cancelActionText != null){
      actions.add(
          PlatformAlertDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelActionText!),
          )
      );
    }
    actions.add(
        PlatformAlertDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(defaultActionText),
        )
    );
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    // TODO: implement buildCupertinoWidget
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    // TODO: implement buildMaterialWidget
    print('buildMaterialWidget method called');
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
