import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wpfamilylastseen/src/app/constants/colors.dart';

class ConnectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: padding.top),
        child: Scaffold(
          backgroundColor: Colorize.white,
          body: Column(
            children: [
              Lottie.asset('assets/connectivity.json'),
            ],
          ),
        ),
      ),
    );
  }
}
