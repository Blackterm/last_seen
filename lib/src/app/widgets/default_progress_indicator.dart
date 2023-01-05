import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpfamilylastseen/src/app/constants/colors.dart';

class DefaultProgressIndicator extends StatelessWidget {
  final Color color;

  DefaultProgressIndicator({this.color = Colorize.primary});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(radius: 15)
          : CircularProgressIndicator(color: color),
    );
  }
}
