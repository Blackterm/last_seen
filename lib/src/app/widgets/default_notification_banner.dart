import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class DefaultNotificationBanner {
  final Widget icon;
  final String text;
  final Color color;
  final BuildContext context;

  DefaultNotificationBanner({
    required this.icon,
    required this.text,
    required this.color,
    required this.context,
  });

  void show() {
    // ignore: avoid_single_cascade_in_expression_statements
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      icon: Padding(
        padding: EdgeInsets.only(left: 15),
        child: icon,
      ),
      onTap: (flushbar) => flushbar.dismiss(),
      messageText: Padding(
        padding: EdgeInsets.only(left: 8, right: 9),
        child: Text(
          text,
          // ignore: prefer_const_constructors
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: color,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        ),
      ],
    )..show(context);
  }
}
