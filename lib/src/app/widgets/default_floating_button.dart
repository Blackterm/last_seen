import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:wpfamilylastseen/src/app/constants/colors.dart';
import 'package:wpfamilylastseen/src/app/constants/last_seen_icons.dart';

class DefaultFloatingButton extends StatelessWidget {
  final Function()? pressed;
  final String? title;

  const DefaultFloatingButton({
    required this.pressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colorize.primary,
      foregroundColor: Colorize.black,
      extendedPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      onPressed: pressed,
      label: Text(title!,
          style: const TextStyle(
              color: Colorize.black,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w900)),
      icon: const Iconify(FluentMdl2.add_phone, color: Colorize.black),
    );
  }
}