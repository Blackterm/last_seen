import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wpfamilylastseen/src/app/constants/colors.dart';

class DefaultLoadingDialog {
  final String text;
  final BuildContext context;

  DefaultLoadingDialog({
    required this.text,
    required this.context,
  });

  show() {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: 200,
          child: Column(
            children: [
              Text(text),
              SizedBox(
                height: 40,
              ),
              SpinKitPouringHourGlass(
                color: Colorize.primary,
                size: size.height * 0.06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
