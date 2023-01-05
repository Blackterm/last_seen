import 'package:flutter/material.dart';

class DefaultLoadingDialog {
  final String text;
  final BuildContext context;

  DefaultLoadingDialog({
    required this.text,
    required this.context,
  });

  show() {
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
              Icon(
                Icons.update,
                size: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
