import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformWidget extends StatelessWidget {
  const PlatformWidget({Key? key}) : super(key: key);
  Widget buildCupertinoWidget(BuildContext context);
  Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    print('build PlatformWidget called');
   if(Platform.isIOS){
     return buildCupertinoWidget(context);
   }
   print('build PlatformWidget called');
   return buildMaterialWidget(context);
  }
}
